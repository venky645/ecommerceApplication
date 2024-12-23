import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginViewIntegration extends StatelessWidget {
  LoginViewIntegration({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login__')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: userNameController,
            key: const Key('user_name'),
            style: TextStyle(backgroundColor: Colors.green),
          ),
          TextField(
            controller: passwordController,
            key: const Key('password'),
          ),
          ElevatedButton(
              onPressed: () {
                print('username :  ${userNameController.text}');
                print('password :  ${userNameController.text}');
                if (userNameController.text == 'userName' &&
                    passwordController.text == 'password') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SizedBox();
                  }));
                }
              },
              child: Text('submit'))
        ],
      ),
    );
  }
}
