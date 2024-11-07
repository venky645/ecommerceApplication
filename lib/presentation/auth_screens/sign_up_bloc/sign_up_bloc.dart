import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_event.dart';
import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpIntial()) {
    on<SignUp>((event, emit) async {
      User? user = await FirebaseAuthService().signUpWithUserNameAndPassword(
          email: event.email,
          password: event.password,
          contact: event.mobile,
          userName: event.userName);
      if (user != null) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure('signup failure'));
      }
    });

    // Form Validation
    on<UserNameValidation>((event, emit) {
      print('hello : ${event.userName}');
      if (event.userName.length > 10) {
        print('usernamevalidation : length amount greater than 10  ');
        emit(const ValidationFailure(
            eventName: 'UserNameValidation',
            error: 'username should not exceed more than 10 chars'));
      } else {
        emit(const ValidationSuccess(
            eventName: 'UserNameValidation', validMsg: 'username validated'));
      }
    });

    on<EmailValidation>((event, emit) {
      final validEmail =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
              .hasMatch(event.emailInput);
      if (event.emailInput.isEmpty) {
        emit(const ValidationSuccess(
            eventName: 'EmailValidation', validMsg: 'email validated'));
      } else if (!validEmail) {
        emit(ValidationFailure(
            eventName: 'EmailValidation',
            error: 'Please Enter Valid Email ID'));
      } else {
        emit(const ValidationSuccess(
            eventName: 'EmailValidation', validMsg: 'email validated'));
      }
    });

    on<PasswordValidation>((event, emit) {
      final hasString = RegExp(r'[a-zA-Z]').hasMatch(event.passwordInput);
      final hasCapitalLetter = RegExp(r'[A-Z]').hasMatch(event.passwordInput);
      final hasNumber = RegExp(r'[0-9]').hasMatch(event.passwordInput);
      final hasSymbol = RegExp(r'[!@#$%^&*()]').hasMatch(event.passwordInput);
      if (event.passwordInput.isEmpty) {
        emit(ValidationSuccess(
            validMsg: 'valid and Strong passowrd',
            eventName: 'PasswordValidation'));
      } else if (event.passwordInput.length < 6) {
        emit(ValidationFailure(
            error: 'password length must be atleast 6',
            eventName: 'PasswordValidation'));
      } else if (hasNumber && hasCapitalLetter && hasString && hasSymbol) {
        emit(ValidationSuccess(
            validMsg: 'valid and Strong passowrd',
            eventName: 'PasswordValidation'));
      } else if (!hasString) {
        emit(ValidationFailure(
            error: 'password should have atleast one letter',
            eventName: 'PasswordValidation'));
      } else if (!hasNumber) {
        emit(ValidationFailure(
            error: 'password should have atleast one number',
            eventName: 'PasswordValidation'));
      } else if (!hasSymbol) {
        emit(ValidationFailure(
            error: 'password should have atleast one symbol',
            eventName: 'PasswordValidation'));
      } else {
        emit(ValidationFailure(
            error: 'password should have atleast one Capital Letter',
            eventName: 'PasswordValidation'));
      }
    });

    on<ConfirmPassWordValidation>((event, emit) {
      if (event.passwordText.isNotEmpty) {
        if (event.confirmPassInput.isNotEmpty) {
          if (event.passwordText != event.confirmPassInput) {
            emit(ValidationFailure(
                error: 'password not matched',
                eventName: 'ConfirmPassWordValidation'));
          } else {
            emit(ValidationSuccess(
                validMsg: 'password matched',
                eventName: 'ConfirmPassWordValidation'));
          }
        } else {
          emit(ValidationSuccess(
              validMsg: 'password not matched',
              eventName: 'ConfirmPassWordValidation'));
        }
      } else {
        emit(ValidationFailure(
            error: 'password field should not be empty',
            eventName: 'ConfirmPassWordValidation'));
      }
    });

    on<PhoneNumberValidation>((event, emit) {
      if (event.phoneNumber.isEmpty) {
        emit(ValidationSuccess(
            validMsg: 'mobile Number Valid',
            eventName: 'PhoneNumberValidation'));
      } else if (event.phoneNumber.length < 10) {
        emit(ValidationFailure(
            error: 'Mobile Number length should be 10',
            eventName: 'PhoneNumberValidation'));
      } else {
        emit(ValidationSuccess(
            validMsg: 'mobile Number Valid',
            eventName: 'PhoneNumberValidation'));
      }
    });
  }
}
