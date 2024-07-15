import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class LankmarkPainter extends CustomPainter {
  LankmarkPainter({
    //required this.image,
    required this.pose,
  });
  //final ui.Image image; // MK kitへの入力画像
  final Pose pose; // ML kitの出力

  // (1) ランドマークを分類
  List<PoseLandmarkType> get faceLandmarks => [
    PoseLandmarkType.leftEyeInner,
    PoseLandmarkType.leftEye,
    PoseLandmarkType.leftEyeOuter,
    PoseLandmarkType.rightEyeInner,
    PoseLandmarkType.rightEye,
    PoseLandmarkType.rightEyeOuter,
    PoseLandmarkType.leftEar,
    PoseLandmarkType.rightEar,
    PoseLandmarkType.leftMouth,
    PoseLandmarkType.rightMouth,
  ];
  List<PoseLandmarkType> get rightArmLandmarks => [
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.rightElbow,
    PoseLandmarkType.rightWrist,
    PoseLandmarkType.rightThumb,
    PoseLandmarkType.rightIndex,
    PoseLandmarkType.rightPinky,
  ];
  List<PoseLandmarkType> get leftArmLandmarks => [
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.leftElbow,
    PoseLandmarkType.leftWrist,
    PoseLandmarkType.leftThumb,
    PoseLandmarkType.leftIndex,
    PoseLandmarkType.leftPinky,
  ];
  List<PoseLandmarkType> get rightLegLandmarks => [
    PoseLandmarkType.rightHip,
    PoseLandmarkType.rightKnee,
    PoseLandmarkType.rightAnkle,
    PoseLandmarkType.rightHeel,
    PoseLandmarkType.rightFootIndex,
  ];
  List<PoseLandmarkType> get leftLegLandmarks => [
    PoseLandmarkType.leftHip,
    PoseLandmarkType.leftKnee,
    PoseLandmarkType.leftAnkle,
    PoseLandmarkType.leftHeel,
    PoseLandmarkType.leftFootIndex,
  ];

  @override
  void paint(canvas, size) async {
    const strokeWidth = 4.0;

    // (2)
    // 元画像の描画
    //canvas.drawImage(image, Offset.zero, Paint());

    double maxWidth = 800;
    double maxHight = 1250;
    // ランドマークの描画
    final resizeWidth = (x) => maxWidth-(x/maxWidth*size.width)-460;

    final resizeHeight = (y) => (y/maxHight*size.height);
    // (3)
    // 顔
    for (var landmark in faceLandmarks) {
      final paint = Paint()..color = landmark.color;
      final position = Offset(
          resizeWidth(pose.landmarks[landmark]!.x),
          resizeHeight(pose.landmarks[landmark]!.y));
      canvas.drawCircle(position, strokeWidth, paint);
    }

    // (4)
    // 胴体
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = strokeWidth;
    // 左右の方と脚の付け根の座標
    final p1 = Offset(
        resizeWidth(pose.landmarks[rightArmLandmarks.first]!.x),
        resizeHeight(pose.landmarks[rightArmLandmarks.first]!.y));
    final p2 = Offset(
        resizeWidth(pose.landmarks[leftArmLandmarks.first]!.x),
        resizeHeight(pose.landmarks[leftArmLandmarks.first]!.y));
    final p3 = Offset(
        resizeWidth(pose.landmarks[leftLegLandmarks.first]!.x),
        resizeHeight(pose.landmarks[leftLegLandmarks.first]!.y));
    final p4 = Offset(
        resizeWidth(pose.landmarks[rightLegLandmarks.first]!.x),
        resizeHeight(pose.landmarks[rightLegLandmarks.first]!.y));
    // 4点をつなぐ直線を描画
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p2, p3, paint);
    canvas.drawLine(p3, p4, paint);
    canvas.drawLine(p4, p1, paint);

    // (5)
    // 左腕の関節を順に描き線で結ぶ
    for (var index = 0; index < leftArmLandmarks.length - 1; index++) {
      final landmark1 = leftArmLandmarks[index];
      final landmark2 = leftArmLandmarks[index + 1];
      final paint = Paint()
        ..color = landmark1.color
        ..strokeWidth = strokeWidth;
      final p1 = Offset(
          resizeWidth(pose.landmarks[landmark1]!.x),
          resizeHeight(pose.landmarks[landmark1]!.y));
      final p2 = Offset(
          resizeWidth(pose.landmarks[landmark2]!.x),
          resizeHeight(pose.landmarks[landmark2]!.y));
      canvas.drawCircle(p1, strokeWidth, paint);
      if (index < leftArmLandmarks.length - 1) {
        canvas.drawLine(p1, p2, paint);
      }
    }

    for (var index = 0; index < rightArmLandmarks.length - 1; index++) {
      final landmark1 = rightArmLandmarks[index];
      final landmark2 = rightArmLandmarks[index + 1];
      final paint = Paint()
        ..color = landmark1.color
        ..strokeWidth = strokeWidth;
      final p1 = Offset(
          resizeWidth(pose.landmarks[landmark1]!.x),
          resizeHeight(pose.landmarks[landmark1]!.y));
      final p2 = Offset(
          resizeWidth(pose.landmarks[landmark2]!.x),
          resizeHeight(pose.landmarks[landmark2]!.y));
      canvas.drawCircle(p1, strokeWidth, paint);
      if (index < rightArmLandmarks.length - 1) {
        canvas.drawLine(p1, p2, paint);
      }
    }

    for (var index = 0; index < rightLegLandmarks.length - 1; index++) {
      final landmark1 = rightLegLandmarks[index];
      final landmark2 = rightLegLandmarks[index + 1];
      final paint = Paint()
        ..color = landmark1.color
        ..strokeWidth = strokeWidth;
      final p1 = Offset(
          resizeWidth(pose.landmarks[landmark1]!.x),
          resizeHeight(pose.landmarks[landmark1]!.y));
      final p2 = Offset(
          resizeWidth(pose.landmarks[landmark2]!.x),
          resizeHeight(pose.landmarks[landmark2]!.y));
      canvas.drawCircle(p1, strokeWidth, paint);
      if (index < rightLegLandmarks.length - 1) {
        canvas.drawLine(p1, p2, paint);
      }
    }

    for (var index = 0; index < leftLegLandmarks.length - 1; index++) {
      final landmark1 = leftLegLandmarks[index];
      final landmark2 = leftLegLandmarks[index + 1];
      final paint = Paint()
        ..color = landmark1.color
        ..strokeWidth = strokeWidth;
      final p1 = Offset(
          resizeWidth(pose.landmarks[landmark1]!.x),
          resizeHeight(pose.landmarks[landmark1]!.y));
      final p2 = Offset(
          resizeWidth(pose.landmarks[landmark2]!.x),
          resizeHeight(pose.landmarks[landmark2]!.y));
      canvas.drawCircle(p1, strokeWidth, paint);
      if (index < leftLegLandmarks.length - 1) {
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// (6)
// ランドマークごとに色を割り当てるextension
extension PoseLandmarkColor on PoseLandmarkType {
  Color get color {
    if (this == PoseLandmarkType.rightHip ||
        this == PoseLandmarkType.rightKnee ||
        this == PoseLandmarkType.rightAnkle ||
        this == PoseLandmarkType.rightHeel ||
        this == PoseLandmarkType.rightFootIndex) {
      return Colors.blue;
    } else if (this == PoseLandmarkType.leftHip ||
        this == PoseLandmarkType.leftKnee ||
        this == PoseLandmarkType.leftAnkle ||
        this == PoseLandmarkType.leftHeel ||
        this == PoseLandmarkType.leftFootIndex) {
      return Colors.pink;
    } else if (this == PoseLandmarkType.leftShoulder ||
        this == PoseLandmarkType.leftElbow ||
        this == PoseLandmarkType.leftWrist ||
        this == PoseLandmarkType.leftPinky ||
        this == PoseLandmarkType.leftIndex ||
        this == PoseLandmarkType.leftThumb) {
      return Colors.deepPurple;
    } else if (this == PoseLandmarkType.rightShoulder ||
        this == PoseLandmarkType.rightElbow ||
        this == PoseLandmarkType.rightWrist ||
        this == PoseLandmarkType.rightPinky ||
        this == PoseLandmarkType.rightIndex ||
        this == PoseLandmarkType.rightThumb) {
      return Colors.green;
    } else {
      return Colors.amber;
    }
  }
}