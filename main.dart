import 'package:flutter/material.dart';
import 'package:kpostticketingsystem/dummy.dart';
import 'package:kpostticketingsystem/filepicker.dart';
import 'package:kpostticketingsystem/newticketcreation.dart';
import 'package:kpostticketingsystem/servicedashboard.dart';
import 'package:kpostticketingsystem/ticketlogin.dart';
import 'package:kpostticketingsystem/ticketregister.dart';
import 'dart:io';

import 'package:kpostticketingsystem/trash.dart';



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: FileUploader(),
    );
  }
}

