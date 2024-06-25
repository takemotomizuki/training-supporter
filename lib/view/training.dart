import 'package:app/pose_detection/pose_classifier_processor.dart';
import 'package:app/view/camera_view.dart';
import 'package:app/pose_detection/pose_detector.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../pose_detection/pose_painter.dart';

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
  final poseClassifierProcessor = PoseClassifierProcessor(isStreamMode: true);

  num count = 0;
  bool isCurled = false;
  num threshHold = 10;
  num initDiff = -1;

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
  @override
  void initState() {
    _mode = widget.initialDetectionMode;
    super.initState();

  }

  @override
  void dispose() async {
    // ウィジェットが破棄されたら、コントローラーを破棄
    // _controller.dispose();
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
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await PoseDetect.detect(inputImage);

    // // Todo call method processImage(inputImage); FROM yohei
    // PoseDetectionScreen();
    // final poses = null;
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null &&
        poses != null ) {
      final classificationResult = await poseClassifierProcessor.getPoseResult(poses.first);
      print(poseClassifierProcessor.repCounters!.last.numRepeats);

      final painter = LankmarkPainter(pose: poses.first);
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
