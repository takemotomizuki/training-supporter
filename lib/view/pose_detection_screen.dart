//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'pose_painter.dart'; // 追加
//
// class PoseDetectionScreen extends StatefulWidget {
//   final String imagePath; // 画像のパス
//
//   const PoseDetectionScreen({Key? key, required this.imagePath}) : super(key: key);
//
//   @override
//   _PoseDetectionScreenState createState() => _PoseDetectionScreenState();
// }
//
// class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
//   final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());
//   List<Pose>? _poses;
//   Size? _imageSize;
//
//   @override
//   void initState() {
//     super.initState();
//     _detectPose(widget.imagePath); // 画像のパスからポーズ検出を開始
//   }
//
//   Future<void> _detectPose(String imagePath) async {
//     final inputImage = InputImage.fromFilePath(imagePath);
//     final poses = await _poseDetector.processImage(inputImage);
//
//     setState(() {
//       _poses = poses;
//     });
//   }
//
//   @override
//   void dispose() {
//     _poseDetector.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pose Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _poses != null
//                 ? CustomPaint(
//               painter: PosePainter(_poses!, _imageSize!),
//             )
//                 : CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//


// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'pose_painter.dart'; // 追加

// class PoseDetectionScreen extends StatefulWidget {
//   @override
//   _PoseDetectionScreenState createState() => _PoseDetectionScreenState();
// }

// class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
//   final ImagePicker _picker = ImagePicker();
//   final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());
//   XFile? _image;
//   List<Pose>? _poses;
//   Size? _imageSize;

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _image = image;
//       });
//       await _getImageSize(File(image.path));
//       await _detectPose(image);
//     }
//   }

//   Future<void> _getImageSize(File imageFile) async {
//     final completer = Completer<Size>();
//     final image = Image.file(imageFile);
//     image.image.resolve(ImageConfiguration()).addListener(
//       ImageStreamListener((ImageInfo info, bool _) {
//         completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()));
//       }),
//     );
//     _imageSize = await completer.future;
//     setState(() {});
//   }

//   Future<void> _detectPose(XFile image) async {
//     final inputImage = InputImage.fromFilePath(image.path);
//     final poses = await _poseDetector.processImage(inputImage);

//     setState(() {
//       _poses = poses;
//     });
//   }

//   @override
//   void dispose() {
//     _poseDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pose Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image != null
//                 ? _imageSize != null
//                 ? Stack(
//               children: [
//                 Image.file(
//                   File(_image!.path),
//                   width: 300,
//                   fit: BoxFit.contain,
//                 ),
//                 Positioned.fill(
//                   child: CustomPaint(
//                     painter: PosePainter(_poses!, _imageSize!),
//                   ),
//                 ),
//               ],
//             )
//                 : CircularProgressIndicator()
//                 : Text('No image selected.'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image from Gallery'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
