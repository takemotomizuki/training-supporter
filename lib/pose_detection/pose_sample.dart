import 'package:app/pose_detection/point_3d.dart';
import 'package:app/pose_detection/pose_embedding.dart';

class PoseSample {
  static const String TAG = 'PoseSample';
  static const int NUM_LANDMARKS = 33;
  static const int NUM_DIMS = 3;

  final String name;
  final String className;
  final List<Point3d> embedding;

  PoseSample(this.name, this.className, List<Point3d> landmarks)
      : embedding = PoseEmbedding.getPoseEmbedding(landmarks);

  String get getName => name;
  String get getClassName => className;
  List<Point3d> get getEmbedding => embedding;

  static PoseSample? getPoseSample(String csvLine, String separator) {
    List<String> tokens = csvLine.split(separator);
    if (tokens.length != (NUM_LANDMARKS * NUM_DIMS) + 2) {
      print('[$TAG] Invalid number of tokens for PoseSample');
      return null;
    }
    String name = tokens[0];
    String className = tokens[1];
    List<Point3d> landmarks = [];
    try {
      for (int i = 2; i < tokens.length; i += NUM_DIMS) {
        landmarks.add(Point3d(
          double.parse(tokens[i]),
          double.parse(tokens[i + 1]),
          double.parse(tokens[i + 2]),
        ));
      }
    } catch (e) {
      print('[$TAG] Invalid value for landmark position: $e');
      return null;
    }
    return PoseSample(name, className, landmarks);
  }
}

