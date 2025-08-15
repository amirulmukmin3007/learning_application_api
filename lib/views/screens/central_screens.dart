import 'package:flutter/material.dart';
import 'package:learning_application_api/views/screens/form.dart';
import 'package:learning_application_api/views/screens/home.dart';

class CentralScreen extends StatefulWidget {
  @override
  _CentralScreenState createState() => _CentralScreenState();
}

class _CentralScreenState extends State<CentralScreen> {
  int _currentIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [HomePage(), FormPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: 'Form'),
        ],
      ),
    );
  }
}
