import 'package:flutter/material.dart';


class Training extends StatefulWidget {
  const Training({super.key, required this.title});

  final String title;

  @override
  State<Training> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Training> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
