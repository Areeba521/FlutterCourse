import 'package:f_timer/timer/view/timer_page.dart';
import 'package:flutter/material.dart';
//import 'package:f_timer/timer/timer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(72,72,126,1),
        )
      ),
     home: const TimerPage(),
    );
  }
}