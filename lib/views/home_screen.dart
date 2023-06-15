import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebace_demo/firebase_service/email_auth_service.dart';
import 'package:firebace_demo/firebase_service/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../commen_wigets/Comman_text.dart';
import 'Email Authentication/login_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Comman_Text(
                  text: "Home Screen",
                  color: Colors.black,
                  fontsize: 25,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              // Container(
              //   height: 150,
              //   width: 150,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.grey.shade300,
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              IconButton(
                  onPressed: () {
                    EmailAuthService.LogoutUser().then((value) async {
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      GoogleAuthService.googleSignOut();
                      sh
                          .remove("email")
                          .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login_Screen(),
                                ),
                              ));
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 40,
                  ))
            ],
          );
        },
      ),
    );
  }
}
