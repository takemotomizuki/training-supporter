import 'dart:math';
import 'package:app/pose_detection/classification_result.dart';
import 'package:app/pose_detection/point_3d.dart';
import 'package:app/pose_detection/pose_sample.dart';
import 'package:collection/collection.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseClassifier {
  static const int MAX_DISTANCE_TOP_K = 30;
  static const int MEAN_DISTANCE_TOP_K = 10;

  final List<PoseSample> poseSamples;
  final int maxDistanceTopK;
  final int meanDistanceTopK;
  final Point3d axesWeights;

  PoseClassifier(this.poseSamples,
      {int? maxDistanceTopK, int? meanDistanceTopK, Point3d? axesWeights})
      : this.maxDistanceTopK = maxDistanceTopK ?? MAX_DISTANCE_TOP_K,
        this.meanDistanceTopK = meanDistanceTopK ?? MEAN_DISTANCE_TOP_K,
        this.axesWeights = axesWeights ?? Point3d.from(1, 1, 0.2);

  static List<Point3d> extractPoseLandmarks(Pose pose) {
    return pose.landmarks.entries.map((l) => Point3d(l.value.x, l.value.y, l.value.z)).toList();
  }

  int confidenceRange() {
    return min(maxDistanceTopK, meanDistanceTopK);
  }

  ClassificationResult classify(Pose pose) {
    return classifyWithLandmarks(extractPoseLandmarks(pose));
  }

  ClassificationResult classifyWithLandmarks(List<Point3d> landmarks) {
    ClassificationResult result = ClassificationResult();

    if (landmarks.isEmpty) {
      return result;
    }

    List<Point3d> flippedLandmarks = List.from(landmarks);
    for (int i = 0; i < flippedLandmarks.length; i++) {
      flippedLandmarks[i] = flippedLandmarks[i].multiply(Point3d.from(-1, 1, 1));
    }

    List<Point3d> embedding = getPoseEmbedding(landmarks);
    List<Point3d> flippedEmbedding = getPoseEmbedding(flippedLandmarks);

    PriorityQueue<MapEntry<PoseSample, double>> maxDistances = PriorityQueue(
            (a, b) => -a.value.compareTo(b.value));

    for (PoseSample poseSample in poseSamples) {
      List<Point3d> sampleEmbedding = poseSample.embedding;

      double originalMax = 0;
      double flippedMax = 0;

      int size = min(embedding.length, sampleEmbedding.length);
      for (int i = 0; i < size; i++) {
        originalMax = max(originalMax,
            (embedding[i].subtract(sampleEmbedding[i]).multiply(axesWeights)).maxAbs());
        flippedMax = max(flippedMax,
            (flippedEmbedding[i].subtract(sampleEmbedding[i]).multiply(axesWeights)).maxAbs());
      }

      maxDistances.add(MapEntry(poseSample, min(originalMax, flippedMax)));
      if (maxDistances.length > maxDistanceTopK) {
        maxDistances.removeFirst();
      }
    }

    PriorityQueue<MapEntry<PoseSample, double>> meanDistances = PriorityQueue(
            (a, b) => -a.value.compareTo(b.value));

    for (MapEntry<PoseSample, double> sampleDistances in maxDistances.toList()) {
      PoseSample poseSample = sampleDistances.key;
      List<Point3d> sampleEmbedding = poseSample.embedding;

      double originalSum = 0;
      double flippedSum = 0;
      int size = min(embedding.length, sampleEmbedding.length);
      for (int i = 0; i < size; i++) {
        originalSum += (embedding[i].subtract(sampleEmbedding[i]).multiply(axesWeights)).sumAbs();
        flippedSum += (flippedEmbedding[i].subtract(sampleEmbedding[i]).multiply(axesWeights)).sumAbs();
      }

      double meanDistance = min(originalSum, flippedSum) / (embedding.length * 2);
      meanDistances.add(MapEntry(poseSample, meanDistance));
      if (meanDistances.length > meanDistanceTopK) {
        meanDistances.removeFirst();
      }
    }

    for (MapEntry<PoseSample, double> sampleDistances in meanDistances.toList()) {
      String className = sampleDistances.key.className;
      result.incrementClassConfidence(className);
    }

    return result;
  }

  List<Point3d> getPoseEmbedding(List<Point3d> landmarks) {
    // Placeholder for getPoseEmbedding implementation
    return landmarks;
  }
}
