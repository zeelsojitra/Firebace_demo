import 'dart:async';
import 'package:firebace_demo/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Email Authentication/login_screen.dart';
import 'Phone Authentication/enter mobile no.dart';

class Splach_Screen extends StatefulWidget {
  const Splach_Screen({Key? key}) : super(key: key);

  @override
  State<Splach_Screen> createState() => _Splach_ScreenState();
}

class _Splach_ScreenState extends State<Splach_Screen> {
  String? Email;
  Future GetEmail() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    final name = sh.getString("email");
    setState(() {
      Email = name;
    });
  }

  @override
  void initState() {
    GetEmail().whenComplete(() => Timer(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Email == null ? Login_Screen() : Home_Screen(),
            ),
          );
        }));

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.flutter_dash,
              color: Colors.black,
              size: 140,
            ),
          ),
          SizedBox(
            height: 250,
          ),
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
