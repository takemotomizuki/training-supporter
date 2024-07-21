// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userId});
  final String userId;

  static const String _title = 'BottomNavBar Code Sample';
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<DocumentSnapshot> historyList = [];
  List<DocumentSnapshot> menuList = [];
  List<BarChartGroupData> historyDataList = [];
  Future getTrainigHistory() async {
    await Firebase.initializeApp();
    final historyRef = FirebaseFirestore.instance.collection('TrainingHistory');
    final menuRef = FirebaseFirestore.instance.collection('TrainingMenu');

    final week = Timestamp.fromDate(DateTime.now().add(Duration(days: 8) * -1));
    // print(week.toDate());
    final snapshot = await historyRef
        .where("userId", isEqualTo: widget.userId)
        .orderBy("date")
        .where("date", isGreaterThanOrEqualTo: week)
        .get();
    // .where("date", isGreaterThanOrEqualTo: week)
    // .where("userId", isEqualTo: int.parse(widget.userId))
    // .get(); // userId
    // final snapshotMenu = await menuRef.get();
    historyList = snapshot.docs;
    // menuList = snapshotMenu.docs;
  }

  List<BarChartGroupData> formatGraphData(
    historyList,
  ) {
    List<BarChartGroupData> historyDataList_ = [];
    final formatter = DateFormat('d');
    if (historyList.length() == 0) return historyDataList_;
    var trainingDate =
        int.parse(formatter.format(historyList[0]['date'].toDate()));
    var counts = 0.0;
    for (final history in historyList) {
      print(history.data());
      print(history['date'].toDate());
      // print(history['trainingId']);
      // print(history['userId']);
      // print(history['times']);
      if (trainingDate !=
          int.parse(formatter.format(history['date'].toDate()))) {
        historyDataList_.add(BarChartGroupData(x: trainingDate, barRods: [
          BarChartRodData(toY: counts, width: 15, color: Colors.amber)
        ]));
        counts = 0.0 + history['times'];
        trainingDate = int.parse(formatter.format(history['date'].toDate()));
      } else {
        counts += history['times'];
      }
      trainingDate = int.parse(formatter.format(history['date'].toDate()));
    }
    if (counts != 0.0) {
      historyDataList_.add(BarChartGroupData(x: trainingDate, barRods: [
        BarChartRodData(toY: counts, width: 15, color: Colors.amber)
      ]));
    }
    return historyDataList_;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    CalendarFormat _calendarFormat = CalendarFormat.month;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Training Supporter",
            style:
                TextStyle(fontFamily: "Noto Sans", fontWeight: FontWeight.bold),
          ),
        ),
        // debugShowCheckedModeBanner: false,
        // title: Home._title,
        // home: FutureBuilder(
        body: FutureBuilder(
          future: getTrainigHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("LOADING"),
              );
            } else {
              // print('helo');
              // print(historyDataList.length);
              // print(historyList.length);
              historyDataList = formatGraphData(historyList);
              // print(historyDataList.length);
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 1, 1),
                          lastDay: DateTime.utc(2030, 1, 1),
                          focusedDay: DateTime.now(),
                          calendarFormat: _calendarFormat,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() {
                                _calendarFormat = CalendarFormat.twoWeeks;
                              });
                            }
                          },
                          // onDaySelected:(selectedDay, focusedDay) {
                          //   selectedDay=
                          // },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.95,
                        height: screenWidth * 0.95 * 0.65,
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(
                              border: const Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              ),
                            ),
                            titlesData: const FlTitlesData(
                              topTitles: AxisTitles(
                                axisNameWidget: Text(
                                  "1週間トレーニング履歴",
                                ),
                                axisNameSize: 35.0,
                              ),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            groupsSpace: 10,
                            barGroups: historyDataList,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        )
        // home: Card(
        //   shadowColor: Colors.transparent,
        //   margin: EdgeInsets.all(8.0),
        //   child: SizedBox.expand(
        //     child: Center(
        //       child: Text(
        //         'Home page',
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}

  // class TableCalendarSample extends StatelessWidget {
  // const TableCalendarSample({super.key});

  // @override
  // Widget build(BuildContext context) {
  // return Scaffold(
  // appBar: AppBar(
  // title: const Text('カレンダー'),
  // ),
  // body: TableCalendar(
  // firstDay: DateTime.utc(2010, 1, 1),
  // lastDay: DateTime.utc(2030, 1, 1),
  // focusedDay: DateTime.now(),
  // ),
  // );
  // }
  // }
