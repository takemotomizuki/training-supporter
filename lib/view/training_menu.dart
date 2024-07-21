import 'dart:ffi';
import 'dart:math';

// import 'package:app/view/firestore.dart';
import 'package:app/view/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';

class TrainingMenu extends StatefulWidget {
  TrainingMenu({super.key, required this.title});

  final String title;

  @override
  State<TrainingMenu> createState() => TrainingMenuState();
}

class TrainingMenuState extends State<TrainingMenu> {
  List<DocumentSnapshot> menus = [];
  Future getTrainingMenu() async {
    await Firebase.initializeApp();
    final snapshot =
        await FirebaseFirestore.instance.collection('TrainingMenu').get();
    menus = snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double height = 110;
    return Scaffold(
      body: FutureBuilder(
        future: getTrainingMenu(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("LOADING"),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(
                  left: 30, top: 100, right: 30, bottom: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: menus.map((menu) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => Training(title: 'どうも',)),
                              MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(
                                      title: 'Pose Detector', trainingKeyWord: menu['keyword'], finishCount: menu['times'], trainingId: menu['trainingId'],)),
                              // builder: (context) => Firestor()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: min(height, size.height),
                            width: size.width - 70,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: height,
                                  width: size.width / 3,
                                  child: Center(
                                    child: Text(
                                      "${menu['name']}\n ${menu['times']}",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height,
                                  width: size.width / 3,
                                  child: Center(
                                    child: Image.asset('images/model1.jpg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
