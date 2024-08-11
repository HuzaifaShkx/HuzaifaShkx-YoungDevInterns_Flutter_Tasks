import 'package:e_library_1/Screens/homeScreen.dart';
import 'package:e_library_1/Screens/notesScreen.dart';
import 'package:flutter/material.dart';

class UserdashboardScreen extends StatefulWidget {
  const UserdashboardScreen({super.key});

  @override
  State<UserdashboardScreen> createState() => _UserdashboardScreenState();
}

class _UserdashboardScreenState extends State<UserdashboardScreen> {
  List<Widget> screens=[
    HomeScreen(),
    NotesScreen(),
  
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme:IconThemeData(color: Colors.grey),
        backgroundColor: Colors.grey[900],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.notes),label: "Notes"),
       
      ]),
      body: screens[currentIndex],
    );
  }
}