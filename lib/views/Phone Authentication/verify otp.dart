import 'package:firebace_demo/views/Phone%20Authentication/enter%20mobile%20no.dart';
import 'package:firebace_demo/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../commen_wigets/Comman_Container.dart';
import '../../commen_wigets/Comman_text.dart';

class Verify_Otp extends StatefulWidget {
  const Verify_Otp({Key? key}) : super(key: key);

  @override
  State<Verify_Otp> createState() => _Verify_OtpState();
}

class _Verify_OtpState extends State<Verify_Otp> {
  String? OTP;
  Future VerifyOtp() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode!, smsCode: OTP.toString());
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_Screen(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Comman_Text(
            text: "Invalid Otp",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: false,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                setState(() {
                  OTP = verificationCode;
                });
              }, // end onSubmit
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Comman_Container(
                child: Center(
                    child: Comman_Text(
                  text: "Send Otp",
                  color: Colors.white,
                  fontweight: FontWeight.bold,
                  fontsize: 20,
                )),
                BorderRadius: BorderRadius.circular(40),
                height: height * 0.06,
                width: width,
                color: Colors.indigo,
                ontap: () {
                  VerifyOtp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
