import 'package:firebace_demo/commen_wigets/Comman_Container.dart';
import 'package:firebace_demo/firebase_service/google_auth_service.dart';
import 'package:firebace_demo/views/home_screen.dart';
import 'package:flutter/material.dart';

import '../../commen_wigets/Comman_text.dart';

class Google_authantication extends StatefulWidget {
  const Google_authantication({Key? key}) : super(key: key);

  @override
  State<Google_authantication> createState() => _Google_authanticationState();
}

class _Google_authanticationState extends State<Google_authantication> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Comman_Container(
                BorderRadius: BorderRadius.circular(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                      'asserts/images/google.png',
                      height: 30,
                      width: 30,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Comman_Text(
                      text: "Sing in with google",
                      color: Colors.white,
                      fontweight: FontWeight.bold,
                      fontsize: 18,
                    ),
                  ],
                ),
                ontap: () {

                  GoogleAuthService.signInWithGoogle().then((value) {
                    if (value != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home_Screen(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Email is already in use by another accoount")));
                    }
                  });
                },
                height: height * 0.06,
                width: width,
                color: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
