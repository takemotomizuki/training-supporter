import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class RepetitionCounter {
  RepetitionCounter(String className);
}


class PoseDetect {

  static Future detect(InputImage inputImage) async {

    try{

      final options = PoseDetectorOptions();
      final poseDetector = PoseDetector(options: options);
      final List<Pose> poses = await poseDetector.processImage(inputImage);

      poseDetector.close();
      return poses;
    } catch (e) {
      print("io error");
    }

  }
}
