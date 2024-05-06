
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  Future<User?> signUpWithUserNameAndPassword(String email,String password,String contact,String userName) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      Map<String, dynamic> userInfo = {
        'userName': userName,
        'contact': contact,
      };
      
      _firestore.collection('users').doc(credential.user!.uid).set(userInfo);
      
      
      return credential.user;
    } catch (e){
      print("there is an exception : ${e.toString()}");
    }
    return null;
  }

  Future<User?> signINWithUserNameAndPassword(String email,String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      print("there is an exception : ${e.toString()}");
    }
    return null;
  }

}