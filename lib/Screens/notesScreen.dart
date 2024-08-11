import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_library_1/Screens/noteDetail.dart';
import 'package:e_library_1/Screens/notepad.dart';
import 'package:e_library_1/model/notes.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2E2B3C),
        onPressed: () {
          // Action for adding a new book
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NotepadScreen()));
        },
        child: Icon(Icons.add,color: Colors.white,),
       
      ),
      appBar: AppBar(title: Text("Your Notes",style: TextStyle(color: Colors.white),),backgroundColor: Colors.grey[900],iconTheme: IconThemeData(color: Colors.white),),
      body: Container(
       // padding: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Center(child: Text("${snapshot.error}"));
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
        
            final notes = snapshot.data!.docs.map((doc) => Note.fromFirestore(doc)).toList();
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)));
                  },
                  child: Card(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(note.title,style: TextStyle(fontSize: 20),),
                      IconButton(icon:Icon(Icons.delete),onPressed: (){
                        FirebaseFirestore.instance.collection("notes").doc(note.id).delete();
                      },),
                    ],),
                  )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}