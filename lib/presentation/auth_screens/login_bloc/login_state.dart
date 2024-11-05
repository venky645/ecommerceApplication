import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LogInInitial extends LoginState {}

class LoginInLoading extends LoginState {}

class LogInSuccess extends LoginState {
  final User user;
  const LogInSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class LogInFailure extends LoginState {
  final String error;

  const LogInFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// class EmailValidation extends LoginState {
//   final String error;
//   const EmailValidation({required this.error});
//   @override
//   List<Object> get props => [error];
// }

// class PasswordValidation extends LoginState {
//   final String validMsg;
//   const PasswordValidation({required this.validMsg});
//   @override
//   List<Object> get props => [validMsg];
// }
