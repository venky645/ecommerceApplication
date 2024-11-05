import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginButtonPressed(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

// class LoginEmailValidation extends LoginEvent {
//   final String emailInput;
//   const LoginEmailValidation(this.emailInput);
//   @override
//   List<Object> get props => [emailInput];
// }

// class LoginPasswordValidation extends LoginEvent {
//   final String passwordInput;
//   const LoginPasswordValidation(this.passwordInput);
//   @override
//   List<Object> get props => [passwordInput];
// }
