import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kpostticketingsystem/ticketlogin.dart';


class ticketregister extends StatefulWidget {

  const ticketregister({Key? key}) : super(key: key);


  @override
  State<ticketregister> createState() => _ticketregisterState();
}


class _ticketregisterState extends State<ticketregister> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String? _selectedDept;
  String? _selectedRole;


  final List<String> _deptOptions = ['Marketing', 'Sales', 'Accounts', 'Development', 'IT Support'];
  final List<String> _roleOptions = ['Marketing Manager', 'Accounts Manager', 'Sales Manager'];


  Future _insertEmployee() async {
    final response = await http.post(
      Uri.parse('https://10.0.2.2:7114/api/TicketingSystem/Employeeregister'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{

        'empfullname': _nameController.text,
        'empemail': _emailController.text,
        'emppassword': _passwordController.text,
        'empdept': _selectedDept,
        'empdesignation': _selectedRole,
        'empcreateddate': DateTime.now().toIso8601String(),

      }),
    );

    if (response.statusCode == 200) {
      print('Registration successful');
      return response;
    } else {
      throw Exception('Registered failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 550,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.deepPurpleAccent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.jpg',
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Enter your Name',
                              labelStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Enter your Email',
                              labelStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Select your Department'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: _deptOptions.map((String option) {
                                          return ListTile(
                                            title: Text(option),
                                            onTap: () {
                                              setState(() {
                                                _selectedDept = option;
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Select your Department',
                              labelStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                            controller: TextEditingController(text: _selectedDept),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Select your Role'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: _roleOptions.map((String option) {
                                          return ListTile(
                                            title: Text(option),
                                            onTap: () {
                                              setState(() {
                                                _selectedRole = option;
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Select your Role',
                              labelStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                            controller: TextEditingController(text: _selectedRole),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Enter your Password',
                              labelStyle: const TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 270,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 110,
                                child: TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
                                  onPressed: _insertEmployee,
                                  child: const Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          width: 280,
                          child: Row(
                            children: [
                              const Text("Already have an account?", style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 17)),
                              const SizedBox(width: 15,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,MaterialPageRoute(builder: (context) => const ticketlogin()),); // Pop current screen
                                  },
                                  child: const Text("Sign In", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17))
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

