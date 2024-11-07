import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  final String email;
  final String userName;
  final String password;
  final String mobile;
  const SignUp(
      {required this.email,
      required this.mobile,
      required this.password,
      required this.userName});

  @override
  List<Object> get props => [email, userName, password, mobile];
}

class EmailValidation extends SignUpEvent {
  final String emailInput;
  const EmailValidation(this.emailInput);
  @override
  List<Object> get props => [emailInput];
}

class PasswordValidation extends SignUpEvent {
  final String passwordInput;
  const PasswordValidation(this.passwordInput);
  @override
  List<Object> get props => [passwordInput];
}

class ConfirmPassWordValidation extends SignUpEvent {
  final String confirmPassInput;
  final String passwordText;
  const ConfirmPassWordValidation(this.confirmPassInput, this.passwordText);
  @override
  List<Object> get props => [confirmPassInput];
}

class UserNameValidation extends SignUpEvent {
  final String userName;

  const UserNameValidation(this.userName);
  @override
  List<Object> get props => [userName];
}

class PhoneNumberValidation extends SignUpEvent {
  final String phoneNumber;

  const PhoneNumberValidation(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}
