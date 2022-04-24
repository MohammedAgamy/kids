import 'package:flutter/material.dart';
import 'package:kids/home.dart';
import 'package:kids/test.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (context) => Home(),
        'homeT': (context) => HomeT(),
      },
    );
  }
}
