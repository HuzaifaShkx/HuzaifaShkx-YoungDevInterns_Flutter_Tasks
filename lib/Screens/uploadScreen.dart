import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';


class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController _contName=TextEditingController();
  TextEditingController _contAuthor=TextEditingController();
  TextEditingController _contDesc=TextEditingController();
  String? _uploadStatus;
  String? _filePath;
  File? _bookimage;
  String? downloadURLbook;
  String? downloadURLimage;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [ 'pdf', 'doc','docx','txt'],
    );

    if (result != null) {
      // Get the path of the selected file
      _filePath = result.files.single.path;
      

    setState(() {});
  }
  }

  Future<void> _uploadFile() async {
    try {
      CollectionReference colref=FirebaseFirestore.instance.collection("library1");
      
      if(_filePath!=null){
      String fileName = File(_filePath!).path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref('Books/${fileName}');
      UploadTask uploadTask = storageRef.putFile(File(_filePath!));

        await uploadTask.whenComplete(() async {
         downloadURLbook = await storageRef.getDownloadURL();

        
            
      });
      if(_bookimage!=null){
        Reference storageRef = FirebaseStorage.instance.ref('images/${_bookimage!.path.split('/').last}');
        UploadTask uploadTask = storageRef.putFile(_bookimage!);
        await uploadTask.whenComplete(() async {
        downloadURLimage = await storageRef.getDownloadURL();
        });
      
      colref.add({
        "author":_contAuthor.text,
        "bookname":_contName.text,
        "description":_contDesc.text,
        "bookimagepath":downloadURLimage, // Placeholder image for now
        "filePath":downloadURLbook
      });
      }
      setState(() {
          _uploadStatus = 'File uploaded successfully! URL: $downloadURLbook';
          SnackBar snackBar = SnackBar(content: Text("File Uploaded Successfully"),duration: Duration(seconds: 3),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(_uploadStatus);
           });
            
      }
    } catch (e) {
      setState(() {
        _uploadStatus = 'File upload failed: $e';
      });
    }
  }  

  @override
  Widget build(BuildContext context) {
    
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color(0xff100B20),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: Text("Upload Book",style: TextStyle(color: Colors.white),),
      //  backgroundColor: Color(0xff100B20),
      // ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.blue[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
            MyTextFormField(width: width, controller: _contName,label: "Name",hintText: "Book Name",),
            MyTextFormField(width: width, controller: _contAuthor,label: "Author Name",hintText: "Enter Author Name",),
            MyTextFormField(width: width, controller: _contDesc,label: "Description",hintText: "Book Description",),
            InkWell(
              onTap: _pickFile,
              child: Container(
                alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: 200,
              height: 50,
          
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white60
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link_outlined),
                  SizedBox(width: 10,),
                  Text("Select File"),
                ],
              ),
            ),),
            InkWell(
              onTap: () async {
               XFile? img =await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {
                  _bookimage = File(img!.path);
                });
              },
              child: Container(
                alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: 200,
              height: 50,
          
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white60
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link_outlined),
                  SizedBox(width: 10,),
                  Text("Select Book Image"),
                ],
              ),
            ),),
             InkWell(
              onTap: _uploadFile,
              child: Container(
                alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: 150,
              height: 50,
          
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff100B20),
              ),
              child: Text("Upload Book",style: TextStyle(color: Colors.white),),
            ),)
          ],),
        ),
      ),
    );
  }
}


class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.width,
  required this.controller, required this.label, required this.hintText,
  });

  final double width;
  final TextEditingController controller;
  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey,
        child: Container(
          margin: EdgeInsets.all(10),
          width: width*0.8,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: this.label,hintText: this.hintText,
            //border: OutlineInputBorder()
            ),
          ),
        ),
      ),
    );
  }
}