import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NotepadScreen extends StatefulWidget {
  const NotepadScreen({super.key});

  @override
  State<NotepadScreen> createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  TextEditingController _contText=TextEditingController();
  TextEditingController _contTitle=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notepad"),
        backgroundColor: Color(0xff1F1B2D),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.check),
            onPressed: () async {
              DocumentReference ref=await FirebaseFirestore.instance.collection("notes").add(
                {
                  "title": _contTitle.text,
                  "text": _contText.text,
                }
              );
              if(ref.id !=null){
                SnackBar snackbar=SnackBar(content:Text("Note saved successfully") ,);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                
                _contTitle.clear();
                _contText.clear();
              }
              // Action to share the notepad content
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
           decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  child: Center(
                  
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      controller: _contTitle,
                      cursorColor: Colors.white,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Write your notes Title here...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _contText,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Write your notes here...",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}