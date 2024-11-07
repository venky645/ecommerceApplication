import 'package:ecommerce_app/presentation/auth_screens/sign_up_bloc/sign_up_event.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpIntial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;
  const SignUpFailure(this.error);
}

class ValidationFailure extends SignUpState {
  final String error;
  final String eventName;
  const ValidationFailure({required this.eventName, required this.error});
  @override
  List<Object> get props => [error, eventName];
}

class ValidationSuccess extends SignUpState {
  final String validMsg;
  final String eventName;
  const ValidationSuccess({required this.eventName, required this.validMsg});
  @override
  List<Object> get props => [validMsg, eventName];
}
