import 'dart:io';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetect {

  static Future<void> poseDetect() async {

    try{
      //画像のパスを指定
      //ここで画像を読み込めていない
      final InputImage inputImage = InputImage.fromFilePath("../../assets/images/model1.jpg");

      final options = PoseDetectorOptions();
      final poseDetector = PoseDetector(options: options);

      final List<Pose> poses = await poseDetector.processImage(inputImage);

      for (Pose pose in poses) {
        // to access all landmarks
        pose.landmarks.forEach((_, landmark) {
          final type = landmark.type;
          final x = landmark.x;
          final y = landmark.y;
        });
        // to access specific landmarks
        final landmark = pose.landmarks[PoseLandmarkType.nose];
      }

      poseDetector.close();

    } catch (e) {
      print("io error");
    }

  }
}
