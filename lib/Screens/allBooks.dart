import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_library_1/Screens/bookdetails.dart';
import 'package:e_library_1/model/book.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('library1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100B20),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: Text(
      //     "Uploaded Books Collection",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Color(0xff100B20),
      // ),
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder(
          stream: booksCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text("${snapshot.error}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final books = snapshot.data!.docs
                .map((doc) => Book.fromFirestore(doc))
                .toList();
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookDetailScreen(book: book)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xff2E2B3C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Image.network(
                                    book.bookimagepath!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      overflow: TextOverflow.visible,
                                      book.bookname,
                                      style: TextStyle(
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ),
                                   Text(book.author,style: TextStyle(color: Colors.white60),),
                                  // Text(book.filePath)
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("library1")
                                      .doc(book.id)
                                      .delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white60,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
