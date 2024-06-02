import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Employee {
  int? employeeid;
  String? empfullname;
  String? empusername;
  String? empemail;
  String? emppassword;
  String? empdesignation;
  String? empcreateddate;


  Employee({
    this.employeeid,
    this.empfullname,
    this.empusername,
    this.empemail,
    this.emppassword,
    this.empdesignation,
    this.empcreateddate,
  });


  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeid: json['employeeid'],
      empfullname: json['empfullname'],
      empusername: json['empusername'],
      empemail: json['empemail'],
      emppassword: json['emppassword'],
      empdesignation: json['empdesignation'],
      empcreateddate: json['empcreateddate'],
    );
  }
}


Future<List<Employee>> fetchEmployeeDetails() async {
  final response = await http.get(Uri.parse('https://10.0.2.2:7114/api/TicketingSystem/EmployeeDetails'));


  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body) as List<dynamic>;
    return parsedJson.map((item) => Employee.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load employee details');
  }
}

class ticketlogin extends StatefulWidget {
  const ticketlogin({Key? key}) : super(key: key);


  @override
  _ticketloginState createState() => _ticketloginState();
}


class _ticketloginState extends State<ticketlogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;


    final employees = await fetchEmployeeDetails();
    final employee = employees.firstWhere(
          (emp) => emp.empemail == email && emp.emppassword == password,
      orElse: () => Employee(),
    );


    if (employee.empemail != null && employee.emppassword != null) {
      // once Login successful it will redirect page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicketRegister(employee: employee)),
      );
    } else {
      // error message alert section
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Failed"),
            content: const Text("Invalid email or password"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: 410,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
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
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 42,
                          width: 270,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold),
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
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2.5),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 270,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 270,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.deepPurple),
                                    onPressed: _login,
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 270,
                          child: Row(
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              const SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RegisterForm()),
                                  );
                                },
                                child: const Text(
                                  "Register!",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
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
          ],
        ),
      ),
    );
  }
}


class TicketRegister extends StatelessWidget {
  final Employee? employee;

  const TicketRegister({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Login Sueccessfully'),
      ),
    );
  }
}


class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const Center(
        child: Text('Registration Form'),
      ),
    );
  }
}

