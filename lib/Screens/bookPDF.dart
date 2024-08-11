import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class BookPDFScreen extends StatefulWidget {
  const BookPDFScreen({super.key, required this.filePath});
  final String filePath;
  @override
  State<BookPDFScreen> createState() => _BookPDFScreenState();
}

class _BookPDFScreenState extends State<BookPDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfPdfViewer.network(widget.filePath
                ),
      ),
    );
  }
}