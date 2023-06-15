import 'package:firebace_demo/firebase_service/email_auth_service.dart';
import 'package:firebace_demo/views/Email%20Authentication/signup_screen.dart';
import 'package:firebace_demo/views/home_screen.dart';
import 'package:firebace_demo/views/notescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commen_wigets/Comman_Container.dart';
import '../../commen_wigets/Comman_TeextFiled.dart';
import '../../commen_wigets/Comman_text.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool isLoding = false;
  final Email = TextEditingController();
  final Password = TextEditingController();
  final gloablekey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: gloablekey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Comman_Text(
                text: "Login",
                color: Colors.black,
                fontsize: 27,
                fontweight: FontWeight.bold,
              ),
              SizedBox(
                height: 50,
              ),
              Comman_TexxtFiled(
                controller: Email,
                filled: true,
                fillcolor: Colors.grey.shade300,
                onChanged: (value) {
                  gloablekey.currentState!.validate();
                },
                validator: (value) {
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);

                  if (emailValid) {
                    return null;
                  } else {
                    return "Please enter valid Email Id";
                  }
                },
                hinttext: "Enter Email",
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                disableborder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                FocusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                focouseborder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Comman_TexxtFiled(
                controller: Password,
                filled: true,
                fillcolor: Colors.grey.shade300,
                onChanged: (value) {
                  gloablekey.currentState!.validate();
                },
                validator: (value) {
                  final bool passwordValid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value!);

                  if (value.isEmpty) {
                    return "Required";
                  } else if (passwordValid != true) {
                    return "please enter valid password";
                  }
                },
                hinttext: "Enter Password",
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                disableborder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                FocusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                focouseborder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              isLoding == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Comman_Container(
                        child: Center(
                          child: Comman_Text(
                            text: "Login",
                            color: Colors.white,
                            fontsize: 18,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        height: height * 0.06,
                        width: width,
                        color: Colors.green,
                        BorderRadius: BorderRadius.circular(40),
                        ontap: () async {
                          if (gloablekey.currentState!.validate()) {
                            setState(() {
                              isLoding = true;
                            });
                            EmailAuthService.LoginUser(
                                    password: Password.text, email: Email.text)
                                .then((value) async {
                              if (value != null) {
                                SharedPreferences sh =
                                    await SharedPreferences.getInstance();
                                sh.setString("email", Email.text).then(
                                      (value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Notescreen(),
                                          )),
                                    );
                              } else {
                                setState(() {
                                  isLoding = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Comman_Text(
                                  text: "Invalid Email or Password",
                                )));
                              }
                            });
                          }
                        },
                      ),
                    )
                  : CircularProgressIndicator(),
              SizedBox(
                height: 25,
              ),
              TextButton(
                style: ButtonStyle(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup_Screen(),
                      ));
                },
                child: Comman_Text(
                  text: "Signup Screen",
                  color: Colors.green,
                  fontsize: 18,
                  fontweight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
