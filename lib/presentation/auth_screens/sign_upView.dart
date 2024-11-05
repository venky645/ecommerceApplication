import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_bloc.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_event.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('SignUp Successfull')));
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SignUp',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 78, 139, 189),
                      letterSpacing: 4),
                ),
                Text('Welcome Guest'),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userNameController,
                  style: TextStyle(fontSize: 15),
                  onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context)
                        .add(UserNameValidation(value));
                  },
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'User name',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ValidationFailure &&
                        state.eventName == 'UserNameValidation') {
                      return Text(
                        '*${state.error}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context)
                        .add(EmailValidation(value));
                  },
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ValidationFailure &&
                        state.eventName == 'EmailValidation') {
                      return Text(
                        '*${state.error}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  style: TextStyle(fontSize: 15),
                  onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context)
                        .add(PasswordValidation(value));
                  },
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.remove_red_eye),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ValidationFailure &&
                        state.eventName == 'PasswordValidation') {
                      return Text(
                        '*${state.error}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: confirmPasswordController,
                  style: TextStyle(fontSize: 15),
                  onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context).add(
                        ConfirmPassWordValidation(
                            value, passwordController.text));
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.remove_red_eye),
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ValidationFailure &&
                        state.eventName == 'ConfirmPassWordValidation') {
                      return Text(
                        '*${state.error}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneController,
                  style: TextStyle(fontSize: 15),
                  onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context)
                        .add(PhoneNumberValidation(value));
                  },
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 91, 155, 207),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is ValidationFailure &&
                        state.eventName == 'PhoneNumberValidation') {
                      return Text(
                        '*${state.error}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (userNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        BlocProvider.of<SignUpBloc>(context).add(SignUp(
                            email: emailController.text,
                            mobile: phoneController.text,
                            password: passwordController.text,
                            userName: userNameController.text));
                      } else {
                        print('fields should not be empty');
                      }
                    },
                    child: Text('Submit')),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account?'),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 91, 155, 207)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
