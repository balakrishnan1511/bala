import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileUploader extends StatefulWidget {
  @override
  _FileUploaderState createState() => _FileUploaderState();
}

class _FileUploaderState extends State<FileUploader> {

  String? base64File;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> fileBytes = await file.readAsBytes();
      setState(() {
        base64File = base64Encode(fileBytes);
      });
    }
  }

  Future<void> uploadFile() async {
    if (base64File == null) {
      print("No file selected");
      return;
    }

    var url = Uri.parse("https://10.0.2.2:7114/api/TicketingSystem/Ticketregister");

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'filepath': base64File,
        }),
      );

      if (response.statusCode == 200) {
        print("File uploaded successfully");
      } else {
        print("Failed to upload file. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Uploader"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text("Add an Error Screenshot"),
            ),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
