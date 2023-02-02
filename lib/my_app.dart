import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:window_app/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(
          color: const Color(0xFF6202EE),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 1, 163, 157),
        ),
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
