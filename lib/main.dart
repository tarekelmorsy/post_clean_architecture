import 'package:flutter/material.dart';
import 'package:post_clean_architecture/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'posts app',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold()  ,
    );
  }
}
