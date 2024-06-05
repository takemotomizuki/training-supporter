import 'package:app/view/dashboard.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const Dashboard(title: "Pose detection"),
            );
          // case '/next':
          //   return MaterialPageRoute(
          //     builder: (context) => const NextPage(),
          //   );
          // default:
          //   return MaterialPageRoute(
          //     builder: (context) => const NotFoundPage(),
          //   );
        }
      },
    );
  }
}
