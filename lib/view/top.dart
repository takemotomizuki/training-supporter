
import 'package:app/view/training_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class Top extends StatefulWidget {
  const Top({super.key, required this.userId});
  final String userId;

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        // 下部アイコンの登録
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.local_fire_department)),
            label: 'Training',
          ),
        ],
      ),
      // 遷移先の画面登録

      //body: LoginPage(),


      body: <Widget>[
        Home(userId: "1"),
        TrainingMenu(title: "Training Menu"),
      ][currentPageIndex],
    );

  }
}
