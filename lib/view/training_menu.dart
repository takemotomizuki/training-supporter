import 'package:app/view/training.dart';
import 'package:flutter/material.dart';

class TrainingMenu extends StatefulWidget {
  const TrainingMenu({super.key, required this.title});

  final String title;

  @override
  State<TrainingMenu> createState() => TrainingMenuState();
}

class TrainingMenuState extends State<TrainingMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:
            const EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => Training(title: 'どうも',)),
                        MaterialPageRoute(
                            builder: (context) =>
                                TakePictureScreen(title: 'Pose Detector')),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SizedBox(
                            height: 100,
                            width: 120,
                            child: Center(
                              child: Text(
                                "Squat\n30回",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('images/model1.jpg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(title: 'Pose_Detector'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 110,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
