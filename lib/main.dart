import 'package:flutter/material.dart';
import 'package:learning_application_api/views/screens/central_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Widgets Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CentralScreen(),
    );
  }
}
