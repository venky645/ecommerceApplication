import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithUserNameAndPassword(
      {required String email,
      required String password,
      required String contact,
      required String userName}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Map<String, dynamic> userInfo = {
        'userName': userName,
        'contact': contact,
        'password': password,
        'email': email
      };

      _firestore.collection('users').doc(credential.user!.uid).set(userInfo);
      return credential.user;
    } catch (e) {
      print("there is an exception : ${e.toString()}");
    }
    return null;
  }

  Future<User?> signInWithUserNameAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("there is an exception : ${e.toString()}");
    }
    return null;
  }

  // Future<void> verifyPhoneNumber(String number) async {
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: number,
  //       verificationCompleted: (phoneAuthCredential) async {
  //         await _auth.signInWithPhoneNumber(phoneAuthCredential);
  //       },
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  // }

  Future<User?> getUserDetails() async {
    return _auth.currentUser;
  }
}
