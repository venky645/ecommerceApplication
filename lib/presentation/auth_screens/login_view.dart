import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FirebaseAuthService authService = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login',style: TextStyle(fontSize: 40),),
            Text('welcome user'),
            SizedBox(height: 50,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'please enter your Email...',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'password',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (){
                  login();
                }
                , child: Text('Submit')),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Text('''don't have account?'''),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/signup');
                  },
                    child: Text('SignUp'))
              ],
            )
          ],
        ),
      ),
    );
  }
  void login() async{
    User? user = await authService.signINWithUserNameAndPassword(emailController.text, passwordController.text);
    if (user !=null){
      print("user successfully signed in");
      Navigator.pushNamed(context, '/home');
    } else {
      print("account not found , unable to login");
    }
  }
}
