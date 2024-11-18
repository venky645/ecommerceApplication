import 'package:equatable/equatable.dart';

class ProfileState extends Equatable{
  String profileImage;
  String name;
  String email;
  String phoneNumber;


  @override
  List<Object?> get props => [profileImage,name,email,phoneNumber];

  ProfileState(
      {this.profileImage = '',
      this.name = '',
      this.email = '',
      this.phoneNumber = ''});

  ProfileState copyWith(
      {String? name,
      String? profileImage,
      String? email,
      String? phoneNumber}) {
    return ProfileState(
        profileImage: profileImage ?? this.profileImage,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
