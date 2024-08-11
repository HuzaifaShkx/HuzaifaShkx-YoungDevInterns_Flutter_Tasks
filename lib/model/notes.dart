import 'package:cloud_firestore/cloud_firestore.dart';

class Note{
  final String id;
  final String title;
  final String text;

  Note( {required this.id,required this.title,required this.text});

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Note(
      id:doc.id,
      title: data['title'] ?? '',
      text: data['text'] ?? '',
    );
  }
}