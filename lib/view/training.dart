import 'package:app/view/camera_view.dart';
import 'package:flutter/material.dart';

// for posedetecter
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'detector_view.dart';
// import 'painters/pose_painter.dart';
import 'pose_detection_screen.dart';
import 'pose_painter.dart';

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
enum DetectorViewMode { liveFeed, gallery }

class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({super.key, required this.title});
//   final String title;
//
//   @override
//   State<TakePictureScreen> createState() => TakePictureScreenState();
// }
  const TakePictureScreen({
    super.key,
    required this.title,
    this.onDetectorViewModeChanged,
    this.initialDetectionMode = DetectorViewMode.liveFeed,
    this.onCameraFeedReady,
  });

  final String title;
  final DetectorViewMode initialDetectionMode;
  final Function(DetectorViewMode mode)? onDetectorViewModeChanged;
  final Function()? onCameraFeedReady;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  static List<CameraDescription> cameras = [];
  final initialCameraLensDirection = CameraLensDirection.back;
  var _cameraLensDirection = CameraLensDirection.back;
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  int cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  late DetectorViewMode _mode;
  // final cameras = await availableCameras();
  // late final cameras = availableCameras();
  // late CameraDescription get camera => cameras[0];

  // @override
  // void initState() {
  //   super.initState();
  //   // _initialize();
  //   // final camera = cameras.firstOrNull;

  //   // _controller = CameraController(
  //   //   // カメラを指定
  //   //   // 解像度を定義
  //   //   camera!,
  //   //   ResolutionPreset.medium,
  //   // );

  //   // コントローラーを初期化
  //   // _initializeControllerFuture = _controller.initialize();
  // }
  @override
  void initState() {
    _mode = widget.initialDetectionMode;
    super.initState();
  }

  // void _initialize() async {
  //   if (cameras.isEmpty) {
  //     cameras = await availableCameras();
  //   }
  //   for (var i = 0; i < cameras.length; i++) {
  //     if (cameras[i].lensDirection == initialCameraLensDirection) {
  //       cameraIndex = i;
  //       break;
  //     }
  //   }
  // }

  @override
  void dispose() async {
    // ウィジェットが破棄されたら、コントローラーを破棄
    // _controller.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: _customPaint,
      onImage: _processImage,
      onCameraFeedReady: widget.onCameraFeedReady,
      onDetectorViewModeChanged: _onDetectorViewModeChanged,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    // Todo call method processImage(inputImage); FROM yohei
    // PoseDetectionScreen();
    // final poses = null;
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.metadata!.size,
        // inputImage.metadata!.rotation,
        // _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _onDetectorViewModeChanged() {
    if (_mode == DetectorViewMode.liveFeed) {
      _mode = DetectorViewMode.gallery;
    } else {
      _mode = DetectorViewMode.liveFeed;
    }
    if (widget.onDetectorViewModeChanged != null) {
      widget.onDetectorViewModeChanged!(_mode);
    }
    setState(() {});
  }
}
