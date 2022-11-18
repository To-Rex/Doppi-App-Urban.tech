import 'dart:async';

import 'package:doppi/login_page.dart';
import 'package:doppi/sample_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> nextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(const Duration(milliseconds: 2000), () {
      if (prefs.getString('token') != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const SamplePage();
        }));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }

    });
  }

  @override
  void initState() {
    super.initState();
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                backgroundColor: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}