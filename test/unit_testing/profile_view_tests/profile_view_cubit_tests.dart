import 'package:ecommerce_app/data/service/firebase_auth_service.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_cubit.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_cubit_tests.mocks.dart';

@GenerateMocks([FirebaseAuthService,User,UserCredential])
void main(){
  late ProfileCubit profileCubit;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;
  setUp(() {
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    mockFirebaseAuthService = MockFirebaseAuthService();
    profileCubit = ProfileCubit(firebaseAuthService: mockFirebaseAuthService);
  });

  tearDown(() {
    profileCubit.close();
  });

  test('fetch User Details Success', () async {
    when(mockUser.email).thenReturn('test@example.com');
    when(mockFirebaseAuthService.getUserDetails())
       .thenAnswer((realInvocation) async {
         return mockUser;
    });

   await profileCubit.fetchUserDetails();

   expect(profileCubit.state, ProfileState(email: mockUser.email!));
  });
}