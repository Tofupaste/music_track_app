import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black, fontSize: 16),
          bodyText2: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ),
      home: SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}