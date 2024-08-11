import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String author;
  final String bookname;
  final String description;
  final String? bookimagepath;
  final String filePath;
  final String id;
  Book({
    required this.author,
    required this.bookname,
    required this.description,
    this.bookimagepath,
    required this.filePath,
    required this.id
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Book(
      id:doc.id,
      author: data['author'] ?? '',
      bookname: data['bookname'] ?? '',
      description: data['description'] ?? '',
      bookimagepath: data['bookimagepath'],
      filePath: data['filePath'] ?? '',
    );
  }
}
