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
        fontSize: 80,
        fontWeight: FontWeight.w900,
        shadows: [
          Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.black)
        ]
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
          fontSize: 25,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.black)
          ]
        ),
        text: "初期位置について",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          (size.height));
      textPainter.paint(canvas, drawPosition);
    }
    if(poseEntered && !poseDowned) {
      // トレーニングの回数を表示
      final poseEnterSpan = TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.black)
          ]
        ),
        text: "腰を落として",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          (size.height));
      textPainter.paint(canvas, drawPosition);
    }
    if(poseEntered && poseDowned) {
      // トレーニングの回数を表示
      final poseEnterSpan = TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.black)
          ]
        ),
        text: "元の位置に戻って",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          (size.height));
      textPainter.paint(canvas, drawPosition);
    }

    if(count == 5){
      final poseEnterSpan = TextSpan(
        style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.pink)
            ]
        ),
        text: "がんばって！",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          90);
      textPainter.paint(canvas, drawPosition);
    }
    else if(count == 10){
      final poseEnterSpan = TextSpan(
        style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.pink)
            ]
        ),
        text: "あと半分！",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          90);
      textPainter.paint(canvas, drawPosition);
    }
    else if(count == 15){
      final poseEnterSpan = TextSpan(
        style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(offset: Offset(5,5), blurRadius: 4, color: Colors.pink)
            ]
        ),
        text: "ラストスパート！",
      );
      final textPainter = TextPainter(
        text: poseEnterSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      Offset drawPosition = Offset(
          (size.width - textPainter.width) * 0.5,
          90);
      textPainter.paint(canvas, drawPosition);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
