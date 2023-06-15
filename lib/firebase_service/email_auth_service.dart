import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  static Future<UserCredential?> SignupUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error==>> ${e.message}");
    }
  }

  static Future<UserCredential?> LoginUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign In Error==>> ${e.message}");
    }
  }

  static Future LogoutUser() async {
    try {
      print(FirebaseAuth.instance.currentUser!.email);
      print(FirebaseAuth.instance.currentUser!.uid);
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print("Sign Out Error==>> ${e.message}");
    }
  }
}
