import 'package:bumblebee_tools/pages/todo_page.dart';
import 'package:bumblebee_tools/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('ToDo');
  runApp(const BumbleBee());
}

class BumbleBee extends StatefulWidget {
  const BumbleBee({super.key});

  @override
  State<BumbleBee> createState() => _BumbleBeeState();
}

class _BumbleBeeState extends State<BumbleBee> {
  String appbarTitle = "TO DOs";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BumbleBee Tools",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.amber[300],
              foregroundColor: Colors.black,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black)),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.yellow,
              primary: Colors.yellow,
              secondary: Colors.amber,
              onSecondary: Colors.black54,
              tertiary: Colors.black,
              background: Colors.yellow[200],
              brightness: Brightness.light)),
      routes: {
        '/': (context) => const ToDoPage(),
        '/weather': (context) => const WeatherPage()
      },
    );
  }
}
