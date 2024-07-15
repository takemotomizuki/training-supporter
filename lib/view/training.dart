import 'package:app/painter/count_painter.dart';
import 'package:app/pose_detection/pose_classifier_processor.dart';
import 'package:app/view/camera_view.dart';
import 'package:app/pose_detection/pose_detector.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../painter/pose_painter.dart';

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
  TakePictureScreen({
    super.key,
    required this.title,
    required this.trainingKeyWord,
    this.onDetectorViewModeChanged,
    this.initialDetectionMode = DetectorViewMode.liveFeed,
    this.onCameraFeedReady,
  }) {
    if(_poseClassifierProcessor == null) {
      _poseClassifierProcessor = PoseClassifierProcessor(
        isStreamMode: true,
        trainingKeyword: trainingKeyWord,
      );
    }
  }

  final String title;
  final String trainingKeyWord;
  final DetectorViewMode initialDetectionMode;
  final Function(DetectorViewMode mode)? onDetectorViewModeChanged;
  final Function()? onCameraFeedReady;

  static var _poseClassifierProcessor;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  static List<CameraDescription> cameras = [];
  final initialCameraLensDirection = CameraLensDirection.back;
  var _cameraLensDirection = CameraLensDirection.back;
  num count = 0;
  bool poseEntered = false;
  bool poseDowned = false;
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
    Future<void> _processImage(InputImage inputImage) async {
      _isBusy = true;
      setState(() {
        _text = '';
      });
      final poses = await PoseDetect.detect(inputImage);

        final countPainter = CountPainter(count: count, poseEntered: poseEntered, poseDowned: poseDowned);
        _customPaint = CustomPaint(painter: countPainter);

      // // Todo call method processImage(inputImage); FROM yohei
      // PoseDetectionScreen();
      // final poses = null;
      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null &&
          poses.length != 0 ) {
        final poseResult = await TakePictureScreen._poseClassifierProcessor.getPoseResult(poses.first);
        if(poseResult.first.contains(widget.trainingKeyWord)){
          count = int.parse(poseResult.first.split(':').elementAt(1));
          poseEntered = bool.parse(poseResult.first.split(':').elementAt(2));
          poseDowned = bool.parse(poseResult.first.split(':').elementAt(3));
        }

        // final painter = LankmarkPainter(
        //   pose: poses.first,
        // );
        // _customPaint = CustomPaint(painter: painter);
      } else {
        _text = 'Poses found: ${poses.length}\n\n';
        // TODO: set _customPaint to draw landmarks on top of image
        // _customPaint = null;
      }
      _isBusy = false;
      if (mounted) {
        setState(() {});
      }
    }

    return CameraView(
      customPaint: _customPaint,
      onImage: _processImage,
      onCameraFeedReady: widget.onCameraFeedReady,
      onDetectorViewModeChanged: _onDetectorViewModeChanged,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
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
