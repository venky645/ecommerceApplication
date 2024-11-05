import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_bloc.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_event.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_state.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_bloc.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LogInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('login Successfull')));
            Navigator.pushNamed(context, '/home');
          } else if (state is LogInFailure) {
            alertDialog();
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 78, 139, 189),
                      letterSpacing: 4),
                ),
                Text('welcome user'),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: emailController,
                  style: TextStyle(fontSize: 15),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Enter Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  style: TextStyle(fontSize: 15),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Enter Password',
                      prefixIcon: Icon(
                        Icons.lock_sharp,
                        color: const Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(150.0, 40.0), // Button width and height
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 78, 139, 189))),
                    onPressed: () {
                      print('submit clicked');
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                              emailController.text, passwordController.text));
                    },
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is LoginInLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('''don't have account?'''),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                              color: Color.fromARGB(255, 78, 139, 189)),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 25,
                        child: Image.asset(
                          'assets/icons/google.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 30,
                        child: Image.asset(
                          'assets/icons/phone_num.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> alertDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Column(
              children: [
                Icon(Icons.error_outline, color: Colors.orangeAccent, size: 40),
                SizedBox(height: 10),
                Text(
                  "Invalid Credentials",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          content: Text(
            "Please provide valid credentials.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 114, 164, 204),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "TRY AGAIN",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 12,
        );
      },
    );
  }
}
