import 'package:flutter/material.dart';

// for posedetecter
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'detector_view.dart';
// import 'painters/pose_painter.dart';


class Training extends StatefulWidget {
  const Training({super.key, required this.title});

  final String title;

  @override
  State<Training> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Training> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}


// tezi 0602
/// 写真撮影画面
class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({super.key, required this.title});
//   final String title;
//
//   @override
//   State<TakePictureScreen> createState() => TakePictureScreenState();
// }
  const TakePictureScreen({super.key, required this.title});

  final String title;
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  static List<CameraDescription> cameras = [];
  final initialCameraLensDirection = CameraLensDirection.back;
  int cameraIndex = -1;
  // final cameras = await availableCameras();
  // late final cameras = availableCameras();
  // late CameraDescription get camera => cameras[0];

  @override
  void initState() {
    super.initState();
    _initialize();
    final camera = cameras.first;

    _controller = CameraController(
      // カメラを指定
      camera,
      // 解像度を定義
      ResolutionPreset.medium,
    );

    // コントローラーを初期化
    _initializeControllerFuture = _controller.initialize();
  }

  void _initialize() async {

    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == initialCameraLensDirection) {
        cameraIndex = i;
        break;
      }
    }
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 写真を撮る
          final image = await _controller.takePicture();
          // 表示用の画面に遷移
          // await Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DisplayPictureScreen(imagePath: image.path),
          //     fullscreenDialog: true,
          //   ),
          // );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}


