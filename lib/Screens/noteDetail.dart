import 'package:e_library_1/model/notes.dart';
import 'package:flutter/material.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteDetailScreen({super.key, required this.note});
  final Note note;
  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note.title,style: TextStyle(color: Colors.white),),backgroundColor: Colors.grey[900],iconTheme: IconThemeData(color: Colors.white),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.note.text,style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}