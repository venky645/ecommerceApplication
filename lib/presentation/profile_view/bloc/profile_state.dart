class ProfileState {
  String profileImage;
  String name;
  String email;
  String phoneNumber;

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
