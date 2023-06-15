import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebace_demo/cons.dart';
import 'package:firebace_demo/firebase_service/email_auth_service.dart';
import 'package:firebace_demo/views/notescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../commen_wigets/Comman_Container.dart';
import '../../commen_wigets/Comman_TeextFiled.dart';
import '../../commen_wigets/Comman_text.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  ImagePicker picker = ImagePicker();

  File? image;
  bool isLoding = false;
  final Email = TextEditingController();
  final Password = TextEditingController();
  final gloablekey = GlobalKey<FormState>();
  PickImage(ImageSource imageSource) async {
    final file = await picker.pickImage(source: imageSource);

    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future<String?> uplodeImage() async {
    try {
      await FirebaseStorage.instance.ref('${Email.text}').putFile(image!);
      final url =
          await FirebaseStorage.instance.ref('${Email.text}').getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print("Firebase Storage ==>>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: gloablekey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Comman_Text(
                    text: "Signup",
                    color: Colors.black,
                    fontsize: 27,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        child: Container(
                          child: ClipOval(
                              child: image == null
                                  ? Icon(Icons.camera)
                                  : Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    )),
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 27,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                )),
                                builder: (context) {
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Profile Photo",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 28,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      PickImage(
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.grey,
                                                        size: 35,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      PickImage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                        size: 35,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                text: "Signup",
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
                                EmailAuthService.SignupUser(
                                        email: Email.text,
                                        password: Password.text)
                                    .then((value) async {
                                  if (value != null) {
                                    final imageUrl = await uplodeImage();

                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(wfirebaseAuth.currentUser!.uid)
                                        .set({
                                      "email": Email.text,
                                      "imageUrl": imageUrl,
                                    });
                                    SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                    sh.setString("email", Email.text);
                                    Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Notescreen(),
                                              ),
                                            );
                                  } else {
                                    setState(() {
                                      isLoding = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Comman_Text(
                                      text: "Username already exits",
                                    )));
                                  }
                                });
                              }
                            },
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
