// import 'package:flutter/material.dart';
// //import 'package:google_mlkit_face_detection/google_mlkit_pose_detection.dart';
// import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'camera_view.dart';

// class PoseDetectorView extends StatefulWidget {
//   @override
//   State<PoseDetectorView> createState() => _PoseDetectorViewState();
// }

// class _PoseDetectorViewState extends State<PoseDetectorView> {
//   // ①FaceDetectorのインスタンスを作成
//   final PoseDetector _poseDetector = PoseDetector(options: null!);
//   bool _canProcess = true;
//   bool _isBusy = false;
//   String? _text;



//   @override
//   void dispose() {
//     _canProcess = false;
//     _poseDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CameraView(
//       text: _text,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//     );

//   }




//   // ②顔検出処理のための関数
//   Future<void> processImage(InputImage inputImage) async {
//     if (!_canProcess) return;
//     if (_isBusy) return;
//     _isBusy = true;
//     setState(() {
//       _text = '';
//     });

//     // ③processImage関数に画像を渡す
//     //final poses = await _poseDetector.processImage(inputImage);
//     List<Pose> poses = await _poseDetector.processImage(inputImage);
//     poses.forEach((pose) {
//       Map<PoseLandmarkType, PoseLandmark> lms = pose.landmarks;
//     }

//     // ④検出された顔の数を取得
//     // String text = '検出された顔の数: ${faces.length}\n\n';
//     //
//     // // ⑤検出された顔の笑顔度(smilingProbability)を取得
//     // for (final face in faces) {
//     //   text +=
//     //   'smilingProbabilityの値: ${(face.smilingProbability! * 100).floor()}%\n\n';
//     //   _text = text;
//     // }
//     _isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }