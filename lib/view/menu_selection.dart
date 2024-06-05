import 'package:app/component/footer.dart';
import 'package:app/view/training.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuSelection extends StatefulWidget {
  const MenuSelection({super.key, required this.title});

  final String title;

  @override
  State<MenuSelection> createState() => _DashboardState();
}

class _DashboardState extends State<MenuSelection> {
  int _counter = 8;

  void _incrementCounter() {
    setState(() {     
      _counter += 9;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => Training(title: 'どうも',)),
                    MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen(title: 'Pose_Detector')),
                  );
                },
                child: Text('カメラ起動')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Footer(),
    );
  }
}
