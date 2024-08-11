import 'package:e_library_1/Screens/bookPDF.dart';
import 'package:e_library_1/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //getPDFtext(widget.book.filePath);   
    return Scaffold(
      backgroundColor: Color(0xff1F1B2D),
      appBar: AppBar(
        title: Text("Book Details"),
        backgroundColor: Color(0xff1F1B2D),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Action to share the book details
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: width,
              height: height * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(400, 100),
                  bottomRight: Radius.elliptical(400, 100),
                ),
                child: Image.network(
                  widget.book.bookimagepath!,
                  width: width,
                  height: height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.bookname,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.book.author ?? 'Unknown Author',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.book.description ?? 'No description available.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookPDFScreen(filePath: widget.book.filePath),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text("Read Book"),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
