import 'dart:math';

Point3d subtract(Point3d p1, Point3d p2) {
  return Point3d(p1.x - p2.x, p1.y - p2.y, p1.z - p2.z);
}

double l2Norm2D(Point3d p) {
  return sqrt(p.x * p.x + p.y * p.y);
}
class Point3d {
  final double x, y, z;

  Point3d(this.x, this.y, this.z);

  factory Point3d.from(double x, double y, double z) => Point3d(x, y, z);

  Point3d multiply(Point3d other) => Point3d(x * other.x, y * other.y, z * other.z);

  Point3d subtract(Point3d other) => Point3d(x - other.x, y - other.y, z - other.z);

  double maxAbs() => [x.abs(), y.abs(), z.abs()].reduce(max);

  double sumAbs() => x.abs() + y.abs() + z.abs();

  @override
  String toString() => 'Point3d(x: $x, y: $y, z: $z)';
}