import 'package:app/pose_detection/classification_result.dart';

class RepetitionCounter {
  // These thresholds can be tuned in conjunction with the Top K values in {@link PoseClassifier}.
  // The default Top K value is 10 so the range here is [0-10].
  static const double DEFAULT_ENTER_THRESHOLD = 6.0;
  static const double DEFAULT_EXIT_THRESHOLD = 4.0;

  final String className;
  final double enterThreshold;
  final double exitThreshold;

  int numRepeats;
  bool poseEntered;

  RepetitionCounter(this.className,
      {this.enterThreshold = DEFAULT_ENTER_THRESHOLD, this.exitThreshold = DEFAULT_EXIT_THRESHOLD})
      : numRepeats = 0,
        poseEntered = false;

  /// Adds a new Pose classification result and updates reps for given class.
  ///
  /// @param classificationResult {link ClassificationResult} of class to confidence values.
  /// @return number of reps.
  int addClassificationResult(ClassificationResult classificationResult) {
    double poseConfidence = classificationResult.getClassConfidence(className);

    if (!poseEntered) {
      poseEntered = poseConfidence > enterThreshold;
      return numRepeats;
    }

    if (poseConfidence < exitThreshold) {
      numRepeats++;
      poseEntered = false;
    }

    return numRepeats;
  }

  String getClassName() {
    return className;
  }

  int getNumRepeats() {
    return numRepeats;
  }
}
