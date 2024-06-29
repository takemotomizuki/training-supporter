import 'dart:collection';

import 'package:app/pose_detection/classification_result.dart';

class EMASmoothing {
  static const int DEFAULT_WINDOW_SIZE = 10;
  static const double DEFAULT_ALPHA = 0.2;

  static const int RESET_THRESHOLD_MS = 100;

  final int windowSize;
  final double alpha;
  final Queue<ClassificationResult> window;

  int lastInputMs;

  EMASmoothing({this.windowSize = DEFAULT_WINDOW_SIZE, this.alpha = DEFAULT_ALPHA})
      : window = Queue<ClassificationResult>(),
        lastInputMs = DateTime.now().millisecondsSinceEpoch;

  ClassificationResult getSmoothedResult(ClassificationResult classificationResult) {
    int nowMs = DateTime.now().millisecondsSinceEpoch;

    if (nowMs - lastInputMs > RESET_THRESHOLD_MS) {
      window.clear();
    }
    lastInputMs = nowMs;

    if (window.length == windowSize) {
      window.removeLast();
    }

    window.addFirst(classificationResult);

    Set<String> allClasses = <String>{};
    for (ClassificationResult result in window) {
      allClasses.addAll(result.getAllClasses());
    }

    ClassificationResult smoothedResult = ClassificationResult();

    for (String className in allClasses) {
      double factor = 1;
      double topSum = 0;
      double bottomSum = 0;

      for (ClassificationResult result in window) {
        double value = result.getClassConfidence(className);

        topSum += factor * value;
        bottomSum += factor;

        factor *= (1.0 - alpha);
      }
      smoothedResult.putClassConfidence(className, topSum / bottomSum);
    }

    return smoothedResult;
  }
}
