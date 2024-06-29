import 'package:app/pose_detection/point_3d.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseEmbedding {
  static const double TORSO_MULTIPLIER = 2.5;

  static List<Point3d> getPoseEmbedding(List<Point3d> landmarks) {
    List<Point3d> normalizedLandmarks = normalize(landmarks);
    return getEmbedding(normalizedLandmarks);
  }

  static List<Point3d> normalize(List<Point3d> landmarks) {
    List<Point3d> normalizedLandmarks = List.from(landmarks);
    // Normalize translation.
    Point3d center = average(landmarks[PoseLandmarkType.leftHip.index], landmarks[PoseLandmarkType.rightHip.index]);
    subtractAll(center, normalizedLandmarks);

    // Normalize scale.
    multiplyAll(normalizedLandmarks, 1 / getPoseSize(normalizedLandmarks));
    // Multiplication by 100 is not required, but makes it easier to debug.
    multiplyAll(normalizedLandmarks, 100);
    return normalizedLandmarks;
  }

  // Translation normalization should've been done prior to calling this method.
  static double getPoseSize(List<Point3d> landmarks) {
    // Note: This approach uses only 2D landmarks to compute pose size as using Z wasn't helpful
    // in our experimentation but you're welcome to tweak.
    Point3d hipsCenter = average(
        landmarks[PoseLandmarkType.leftHip.index], landmarks[PoseLandmarkType.rightHip.index]);

    Point3d shouldersCenter = average(
        landmarks[PoseLandmarkType.leftShoulder.index],
        landmarks[PoseLandmarkType.rightShoulder.index]);

    double torsoSize = l2Norm2D(subtract(hipsCenter, shouldersCenter));

    double maxDistance = torsoSize * TORSO_MULTIPLIER;
    // torsoSize * TORSO_MULTIPLIER is the floor we want based on experimentation but actual size
    // can be bigger for a given pose depending on extension of limbs etc so we calculate that.
    for (Point3d landmark in landmarks) {
      double distance = l2Norm2D(subtract(hipsCenter, landmark));
      if (distance > maxDistance) {
        maxDistance = distance;
      }
    }
    return maxDistance;
  }

  static List<Point3d> getEmbedding(List<Point3d> lm) {
    List<Point3d> embedding = [];

    // One joint.
    embedding.add(subtract(
        average(lm[PoseLandmarkType.leftHip.index], lm[PoseLandmarkType.rightHip.index]),
        average(lm[PoseLandmarkType.leftShoulder.index], lm[PoseLandmarkType.rightShoulder.index])
    ));

    embedding.add(subtract(
        lm[PoseLandmarkType.leftShoulder.index], lm[PoseLandmarkType.leftElbow.index]));
    embedding.add(subtract(
        lm[PoseLandmarkType.rightShoulder.index], lm[PoseLandmarkType.rightElbow.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftElbow.index], lm[PoseLandmarkType.leftWrist.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightElbow.index], lm[PoseLandmarkType.rightWrist.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftHip.index], lm[PoseLandmarkType.leftKnee.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightHip.index], lm[PoseLandmarkType.rightKnee.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftKnee.index], lm[PoseLandmarkType.leftAnkle.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightKnee.index], lm[PoseLandmarkType.rightAnkle.index]));

    // Two joints.
    embedding.add(subtract(
        lm[PoseLandmarkType.leftShoulder.index], lm[PoseLandmarkType.leftWrist.index]));
    embedding.add(subtract(
        lm[PoseLandmarkType.rightShoulder.index], lm[PoseLandmarkType.rightWrist.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftHip.index], lm[PoseLandmarkType.leftAnkle.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightHip.index], lm[PoseLandmarkType.rightAnkle.index]));

    // Four joints.
    embedding.add(subtract(lm[PoseLandmarkType.leftHip.index], lm[PoseLandmarkType.leftWrist.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightHip.index], lm[PoseLandmarkType.rightWrist.index]));

    // Five joints.
    embedding.add(subtract(
        lm[PoseLandmarkType.leftShoulder.index], lm[PoseLandmarkType.leftAnkle.index]));
    embedding.add(subtract(
        lm[PoseLandmarkType.rightShoulder.index], lm[PoseLandmarkType.rightAnkle.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftHip.index], lm[PoseLandmarkType.leftWrist.index]));
    embedding.add(subtract(lm[PoseLandmarkType.rightHip.index], lm[PoseLandmarkType.rightWrist.index]));

    // Cross body.
    embedding.add(subtract(lm[PoseLandmarkType.leftElbow.index], lm[PoseLandmarkType.rightElbow.index]));
    embedding.add(subtract(lm[PoseLandmarkType.leftKnee.index], lm[PoseLandmarkType.rightKnee.index]));

    embedding.add(subtract(lm[PoseLandmarkType.leftWrist.index], lm[PoseLandmarkType.rightWrist.index]));
    embedding.add(subtract(lm[PoseLandmarkType.leftAnkle.index], lm[PoseLandmarkType.rightAnkle.index]));

    return embedding;
  }

  PoseEmbedding._();
}

// Utility functions
Point3d average(Point3d p1, Point3d p2) {
  return Point3d(
    (p1.x + p2.x) / 2,
    (p1.y + p2.y) / 2,
    (p1.z + p2.z) / 2,
  );
}

void subtractAll(Point3d center, List<Point3d> points) {
  for (int i = 0; i < points.length; i++) {
    points[i] = subtract(points[i], center);
  }
}

void multiplyAll(List<Point3d> points, double factor) {
  for (int i = 0; i < points.length; i++) {
    points[i] = Point3d(points[i].x * factor, points[i].y * factor, points[i].z * factor);
  }
}




