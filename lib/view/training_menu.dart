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
                                      title: 'Pose Detector', trainingKeyWord: menu['keyword'],)),
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
                // children: <Widget>[
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             // MaterialPageRoute(builder: (context) => Training(title: 'どうも',)),
                //             MaterialPageRoute(
                //                 // builder: (context) =>
                //                 //     TakePictureScreen(title: 'Pose Detector')),
                //                 builder: (context) => Firestore()),
                //           );
                //         },
                //         child: Container(
                //           margin: const EdgeInsets.all(5),
                //           height: min(height, size.height),
                //           width: size.width,
                //           decoration: BoxDecoration(
                //             color: Colors.orangeAccent,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           alignment: Alignment.center,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: <Widget>[
                //               const SizedBox(
                //                 height: 100,
                //                 width: 120,
                //                 child: Center(
                //                   child: Text(
                //                     "Squat\n30回",
                //                     style: TextStyle(
                //                         fontSize: 24, fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 100,
                //                 width: 100,
                //                 child: Image.asset('images/model1.jpg'),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   TakePictureScreen(title: 'Pose_Detector'));
                //         },
                //         child: Container(
                //           margin: const EdgeInsets.all(5),
                //           height: 110,
                //           width: 300,
                //           decoration: BoxDecoration(
                //             color: Colors.orangeAccent,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           alignment: Alignment.center,
                //         ),
                //       ),
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   TakePictureScreen(title: 'Pose_Detector'));
                //         },
                //         child: Container(
                //           margin: const EdgeInsets.all(5),
                //           height: 110,
                //           width: 300,
                //           decoration: BoxDecoration(
                //             color: Colors.orangeAccent,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           alignment: Alignment.center,
                //         ),
                //       ),
                //     ],
                //   ),
                // ],
              ),
            );
          }
        },
      ),
    );
  }

//   Future<Column> getDatabase() async {
//     List<DocumentSnapshot> documentList = [];
//     // final Size size = MediaQuery.of(context).size;
//     const double height = 110;
//     // コレクション内のドキュメント一覧を表示
//     return Column(
//       children: documentList.map((document) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   // MaterialPageRoute(builder: (context) => Training(title: 'どうも',)),
//                   MaterialPageRoute(
//                       // builder: (context) =>
//                       //     TakePictureScreen(title: 'Pose Detector')),
//                       builder: (context) => Firestore()),
//                 );
//               },
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 height: min(height, size.height),
//                 width: size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.orangeAccent,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 100,
//                       width: 120,
//                       child: Center(
//                         child: Text(
//                           // name,
//                           '${document['times']} \n ${document['times']}',
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: Image.asset('images/model1.jpg'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
}
