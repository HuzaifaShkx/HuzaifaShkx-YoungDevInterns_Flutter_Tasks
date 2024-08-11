
import 'package:e_library_1/Screens/allBooks.dart';
import 'package:e_library_1/Screens/uploadScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int currentIndex=0;
  List<Widget> screens=[
    AllBooks(),
    UploadScreen(),
  
  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color(0xff100B20),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(currentIndex==0?"All Books":"Upload Book",style: TextStyle(color: Colors.white),),
       backgroundColor: Color(0xff100B20),),
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
        BottomNavigationBarItem(icon: Icon(Icons.book_rounded),label: "All Books"),
        BottomNavigationBarItem(icon: Icon(Icons.upload),label: "Upload Book"),
       
      ]),
      body:screens[currentIndex]
    );
  }
}