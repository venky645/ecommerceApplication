import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SignUpView extends StatefulWidget {
   const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  FirebaseAuthService _authService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SignUp',style: TextStyle(fontSize: 40),),
            Text('Welcome Guest'),
            SizedBox(height: 30,),

            TextField(
              controller: userNameController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 hintText: 'UserName'
               )
            ),
          SizedBox(height: 10,),
          TextField(
            controller: passwordController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
            hintText: 'Password'
            )),
            SizedBox(height: 10,),

            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password'
                )),
            SizedBox(height: 10,),

            TextField(
              controller: contactController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contact number'
                )),
            SizedBox(height: 10,),

            TextField(
              controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email'
                )),
            SizedBox(height: 10,),

            ElevatedButton(
                onPressed: (){
                  signUp();               },
                child: Text('Submit')
            ),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have account?'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/login');
                  },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      )
    );
  }


  void signUp() async{
    print(emailController.text);
    print(passwordController.text);
    User? user = await _authService.SignUpWithUserNameAndPassword(emailController.text, passwordController.text,contactController.text,userNameController.text);

    if(user != null) {
      print('user Successfully SignedUp');
      Navigator.pushNamed(context, '/home');
    } else {
      print('Some error occur during SignIn');
    }
  }

}
