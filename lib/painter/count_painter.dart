import 'package:flutter/material.dart';

class CountPainter extends CustomPainter {
  CountPainter({
    required this.count,
    required this.poseEntered,
    required this.poseDowned,
  });

  final num count;
  final bool poseEntered;
  final bool poseDowned;

  @override
  void paint(canvas, size) async {
    // トレーニングの回数を表示
    final countSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.orange,
        fontSize: 80,
        fontWeight: FontWeight.bold,
      ),
      text: count.toString(),
    );
    final textPainter = TextPainter(
      text: countSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(10, 10));

    if(!poseEntered) {
      // トレーニングの回数を表示
      final poseEnterSpan = TextSpan(
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        text: "初期位置について",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, const Offset(110, 30));
    }
    if(poseEntered && !poseDowned) {
      // トレーニングの回数を表示
      final poseEnterSpan = TextSpan(
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        text: "腰を落として",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, const Offset(110, 30));
    }
    if(poseEntered && poseDowned) {
      // トレーニングの回数を表示
      final poseEnterSpan = TextSpan(
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        text: "元の位置に戻って",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, const Offset(110, 30));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
