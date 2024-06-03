// import 'package:flutter/material.dart';
// import 'view/pose_detection_screen.dart'; // 追加
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pose Detection',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PoseDetectionScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'view//pose_detection_screen.dart'; // 追加

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pose Detection',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),

      //home: PoseDetectionScreen(imagePath: 'images/model1.jpg'), // 画像のパスを指定
      home: PoseDetectionScreen(), // 画像のパスを指定
    );
  }
}
