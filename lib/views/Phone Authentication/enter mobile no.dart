import 'package:country_picker/country_picker.dart';
import 'package:firebace_demo/commen_wigets/Comman_Container.dart';
import 'package:firebace_demo/commen_wigets/Comman_TeextFiled.dart';
import 'package:firebace_demo/commen_wigets/Comman_text.dart';
import 'package:firebace_demo/views/Phone%20Authentication/verify%20otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? phone;
String? verificationCode;

class Enter_Mobiileno extends StatefulWidget {
  const Enter_Mobiileno({Key? key}) : super(key: key);

  @override
  State<Enter_Mobiileno> createState() => _Enter_MobiilenoState();
}

class _Enter_MobiilenoState extends State<Enter_Mobiileno> {
  final PhonenoControler = TextEditingController();
  final gloablekey = GlobalKey<FormState>();
  String countryCode = "91";
  String countryFlage = "";
  Future sendOtpService() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${PhonenoControler.text}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Comman_Text(
              text: error.message.toString(),
            ),
          ),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Form(
            key: gloablekey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Comman_TexxtFiled(
                  onChanged: (value) {
                    gloablekey.currentState!.validate();
                  },
                  prefixicon: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight:
                                500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = country.phoneCode;
                              countryFlage = country.flagEmoji;
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("+${countryCode}"),
                          Text(countryFlage.isEmpty ? "" : countryFlage),
                        ],
                      ),
                    ),
                  ),
                  sufficicon: PhonenoControler.text.length == 10
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.black,
                        )
                      : SizedBox(),
                  controller: PhonenoControler,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Number";
                    }
                  },
                  hinttext: "Enter Your No",
                  fillcolor: Colors.grey.shade300,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  focouseborder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  FocusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  disableborder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Comman_Container(
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
                    if (gloablekey.currentState!.validate()) {
                      print("Validate");
                      sendOtpService().then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Verify_Otp(),
                            )),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
