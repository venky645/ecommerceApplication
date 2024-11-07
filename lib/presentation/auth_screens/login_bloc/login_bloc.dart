import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_event.dart';
import 'package:ecommerce_app/presentation/auth_screens/login_bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LogInInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInLoading());
      try {
        User? user = await FirebaseAuthService()
            .signInWithUserNameAndPassword(event.email, event.password);
        if (user != null) {
          emit(LogInSuccess(user));
        } else {
          emit(const LogInFailure(error: 'Invalid Credentials'));
        }
      } catch (e) {
        LogInFailure(error: e.toString());
      }
    });
  }
}



//
//   on<LoginButtonPressed>(
//   (event, emit) async* {
//   print('hello');
//   emit(LoginInLoading());
//   try {
//   final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//   email: event.email,
//   password: event.password,
//   );
//   yield LogInSuccess(userCredential.user!);
//   } catch (e) {
//   yield LogInFailure(error: e.toString());
//   }
//   },
//   );
// }
