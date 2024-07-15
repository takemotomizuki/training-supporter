import 'package:app/pose_detection/classification_result.dart';
import 'package:app/pose_detection/reputation_result.dart';

class RepetitionCounter {
  // These thresholds can be tuned in conjunction with the Top K values in {@link PoseClassifier}.
  // The default Top K value is 10 so the range here is [0-10].
  static const double DEFAULT_ENTER_THRESHOLD = 8.0;
  static const double DEFAULT_EXIT_THRESHOLD = 1.0;

  final String className;
  final double enterThreshold;
  final double exitThreshold;

  int numRepeats;
  bool poseEntered;
  bool poseDowned;
  DateTime startTime = DateTime.now();

  RepetitionCounter(this.className,
      {this.enterThreshold = DEFAULT_ENTER_THRESHOLD, this.exitThreshold = DEFAULT_EXIT_THRESHOLD})
      : numRepeats = 0,
        poseEntered = false, poseDowned = false;

  /// Adds a new Pose classification result and updates reps for given class.
  ///
  /// @param classificationResult {link ClassificationResult} of class to confidence values.
  /// @return number of reps.
  ReputationResult addClassificationResult(ClassificationResult classificationResult) {
    double poseConfidence = classificationResult.getClassConfidence(className);
    // if (!poseEntered) {
    //   poseEntered = poseConfidence > enterThreshold;
    //   return numRepeats;
    // }
    //
    // if (poseConfidence < exitThreshold) {
    //   numRepeats++;
    //   poseEntered = false;
    // }
    print(className+":"+poseConfidence.toString()+ "\n" +"flag enter:"+poseEntered.toString()+" downed:"+poseDowned.toString());
    if (!poseEntered) {
      poseEntered = poseConfidence < exitThreshold;
      startTime = DateTime.now();
      return ReputationResult(numRepeat: numRepeats, poseEntered: poseEntered, poseDowned: poseDowned);
    }

    if (poseEntered && !poseDowned && poseConfidence > enterThreshold) {
      if(DateTime.now().difference(startTime).inMilliseconds > 500) {
        poseDowned = true;
      }
      startTime = DateTime.now();
      return ReputationResult(numRepeat: numRepeats, poseEntered: poseEntered, poseDowned: poseDowned);
    }

    if(poseEntered && poseDowned && poseConfidence < exitThreshold) {
      if(DateTime.now().difference(startTime).inMilliseconds > 200) {
        numRepeats++;
        poseEntered = false;
        poseDowned = false;
      }
      startTime = DateTime.now();
      return ReputationResult(numRepeat: numRepeats, poseEntered: poseEntered, poseDowned: poseDowned);
    }

    return ReputationResult(numRepeat: numRepeats, poseEntered: poseEntered, poseDowned: poseDowned);
  }

  String getClassName() {
    return className;
  }

  int getNumRepeats() {
    return numRepeats;
  }
}
