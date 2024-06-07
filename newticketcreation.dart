import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class newticketcreation extends StatefulWidget {
  @override
  _newticketcreationState createState() => _newticketcreationState();
}

class _newticketcreationState extends State<newticketcreation> {
  final TextEditingController _employeenameController = TextEditingController();
  final TextEditingController _employeedepartmentController = TextEditingController();
  final TextEditingController _employeemobileController = TextEditingController();
  final TextEditingController _employeemailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedDepartment;
  double priority = 0;
  String? base64File;
  String? filePath;
  String? errorMessage;
  bool isUploading = false;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        List<int> fileBytes = await file.readAsBytes();
        setState(() {
          base64File = base64Encode(fileBytes);
          filePath = file.path; // Save the file path
          errorMessage = null; // Clear previous error message
        });
        print("Base64 Encoded File: $base64File");
      } else {
        setState(() {
          errorMessage = "No file selected";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Failed to read the file: $e";
      });
    }
  }

  Future<void> _createNewTicket() async {
    setState(() {
      isUploading = true;
    });

    final response = await http.post(
      Uri.parse('https://10.0.2.2:7114/api/TicketingSystem/Ticketregister'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'employeename': _employeenameController.text,
        'employeedepartment': selectedDepartment ?? 'string',
        'employeemobile': _employeemobileController.text,
        'employeemail': _employeemailController.text,
        'subject': _subjectController.text,
        'description': _descriptionController.text,
        'rating': priority.toInt(),
        'filepath': base64File,
      }),
    );

    setState(() {
      isUploading = false;
    });

    if (response.statusCode == 200) {
      print('Registration successful');
      setState(() {
        errorMessage = "Ticket Created successfully.";
        base64File = null; // Clear the base64File after successful upload
        filePath = null; // Clear the file path after successful upload
      });
    } else {
      setState(() {
        errorMessage = "Registration failed. Status code: ${response.statusCode}\nResponse body: ${response.body}";
      });
      throw Exception('Registration failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ticket'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _createNewTicket();
            },
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepOrange, Colors.red, Colors.deepPurple],
            stops: [0.15, 0.39, 0.95],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _employeenameController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name*',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Department*',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: ['IT', 'HR', 'Finance', 'Admin']
                          .map((String department) {
                        return DropdownMenuItem<String>(
                          value: department,
                          child: Text(department),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDepartment = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _employeemobileController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _employeemailController,
                decoration: InputDecoration(
                  labelText: 'Email*',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject*',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description*',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Priority',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < priority ? Icons.star : Icons.star_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        priority = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: pickFile,
                child: Text('Add an Error Screenshot'),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
              if (filePath != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Selected file: $filePath',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              SizedBox(height: 8.0),

              // ElevatedButton(
              //   onPressed: isUploading ? null : _createNewTicket,
              //   child: isUploading ? CircularProgressIndicator() : Text("Submit"),
              // ),

              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),



      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
