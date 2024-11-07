import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> fetchUserDetails() async {
    User? userDetails = await FirebaseAuthService().getUserDetails();
    emit(state.copyWith(email: userDetails!.email));
  }
}
