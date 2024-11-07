import 'package:academy_course/constants/constants.dart';
import 'package:academy_course/mediaQuery/mediaquery_helper.dart';
import 'package:academy_course/presentation/widgets/text_field_widget.dart';
import 'package:academy_course/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends ConsumerState<LoginView> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F4) ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: mediaQueryHelper.responsiveValue(context, 20)),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: mediaQueryHelper.responsiveValue(context, 30)),
            height: mediaQueryHelper.responsiveHeight(context, 500),
            width:double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //login logo
                Container(
                  height: mediaQueryHelper.responsiveHeight(context, 100),
                  width: mediaQueryHelper.responsiveWidth(context, 100),
                  // padding: EdgeInsets.all(mediaQueryHelper.responsiveValue(context, 10)),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                      color:Color(0xFFF9F5F4)
                  ),
                  child: Image.asset('assets/images/women_working.png'),
                ),


                const Text(Constants.loginIn,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                //email and password text fields
                TextFieldWidget(textFieldTitle: Constants.email, textEditingController: emailController,),
                const SizedBox(height: 8),
                TextFieldWidget(textFieldTitle: Constants.password, textEditingController: passwordController,),
                const SizedBox(height: 5,),

                const Align(
                  alignment: Alignment.centerRight,
                    child: Text(Constants.forgetPassword,style: TextStyle(color: Colors.grey),)),
                SizedBox(height: mediaQueryHelper.responsiveHeight(context, 20
                )),

                //Button
                SizedBox(
                  height: mediaQueryHelper.responsiveHeight(context, 60),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor:  Colors.redAccent
                    ),
                      onPressed: () => login(), child: Text(Constants.loginIn,style:TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: mediaQueryHelper.responsiveHeight(context, 20)),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Constants.doNotHaveAnAccount,style: TextStyle(
                color: Colors.grey,fontSize: mediaQueryHelper.responsiveValue(context, 18)
              ),),
              SizedBox(width:mediaQueryHelper.responsiveWidth(context, 5)),
              Text(Constants.signUp,style: TextStyle(
                  color: Colors.black,fontSize: mediaQueryHelper.responsiveValue(context, 20)
              ),)
            ],
          )
        ],
      ),
    );
  }


  void login() async{
    AuthService authService = AuthService();
   User?  user =  await authService.login(emailController.text, passwordController.text);
   if(user != null){
     Navigator.pushNamed(context, '/products');
     Fluttertoast.showToast(
         msg: Constants.successfullyLoggedIn,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         textColor: Colors.white,
         fontSize: 16.0
     );
   } else {
     Fluttertoast.showToast(
         msg: Constants.invalidEmailAddress,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }

  }
}
