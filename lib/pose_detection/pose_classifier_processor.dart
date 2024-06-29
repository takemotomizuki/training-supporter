import 'dart:async';
import 'dart:convert';
import 'package:app/pose_detection/ema_smootjing.dart';
import 'package:app/pose_detection/pose_classifier.dart';
import 'package:app/pose_detection/pose_sample.dart';
import 'package:app/pose_detection/repitation_counter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'classification_result.dart';

class PoseClassifierProcessor {
  static const String TAG = "PoseClassifierProcessor";
  static const String POSE_SAMPLES_FILE = 'assets/fitness_pose_samples.csv';

  static const String PUSHUPS_CLASS = "pushups_down";
  static const String SQUATS_CLASS = "squats_down";
  static const List<String> POSE_CLASSES = [PUSHUPS_CLASS, SQUATS_CLASS];

  final bool isStreamMode;

  EMASmoothing? emaSmoothing;
  List<RepetitionCounter>? repCounters;
  PoseClassifier? poseClassifier;
  String lastRepResult = '';

  PoseClassifierProcessor({required this.isStreamMode}) {
    if (isStreamMode) {
      emaSmoothing = EMASmoothing();
      repCounters = [];
      lastRepResult = '';
    }
    _loadPoseSamples();
  }

  Future<void> _loadPoseSamples() async {
    List<PoseSample> poseSamples = [];
    try {
      final csvData = await rootBundle.loadString(POSE_SAMPLES_FILE);
      LineSplitter.split(csvData).forEach((csvLine) {
        final poseSample = PoseSample.getPoseSample(csvLine, ",");
        if (poseSample != null) {
          poseSamples.add(poseSample);
        }
      });
    } catch (e) {
      debugPrint("Error when loading pose samples.\n$e");
    }

    poseClassifier = PoseClassifier(poseSamples);
    if (isStreamMode) {
      for (String className in POSE_CLASSES) {
        repCounters?.add(RepetitionCounter(className));
      }
    }
  }

  Future<List<String>> getPoseResult(Pose pose) async {
    List<String> result = [];
    ClassificationResult classification = poseClassifier!.classify(pose);

    if (isStreamMode) {
      classification = emaSmoothing!.getSmoothedResult(classification);

      if (pose.landmarks.isEmpty) {
        result.add(lastRepResult);
        return result;
      }

      for (RepetitionCounter repCounter in repCounters!) {
        int repsBefore = repCounter.numRepeats;
        int repsAfter = repCounter.addClassificationResult(classification);
        if (repsAfter > repsBefore) {
          // Play a fun beep when rep counter updates.
          // Note: Flutter does not have a direct equivalent for ToneGenerator, so you would need to use a package like 'flutter_beep'
          lastRepResult = "${repCounter.className} : $repsAfter reps";
          break;
        }
      }
      result.add(lastRepResult);
    }

    if (pose.landmarks.isNotEmpty) {
      String maxConfidenceClass = classification.getMaxConfidenceClass();
      String maxConfidenceClassResult = "${maxConfidenceClass} : ${classification.getClassConfidence(maxConfidenceClass) / poseClassifier!.confidenceRange()} confidence";
      result.add(maxConfidenceClassResult);
    }

    return result;
  }
}

