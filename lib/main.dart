import 'package:flutter/material.dart';
import 'Events.dart';

import 'CameraManagement.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CameraManagementScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

