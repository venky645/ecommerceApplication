import 'package:ecommerce_app/utils/repository_unit.dart';
import 'package:ecommerce_app/utils/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockHttpClient extends Mock implements Client{}

void main(){
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;
  setUp((){
    mockHttpClient = MockHttpClient();
    userRepository = UserRepository(mockHttpClient);

  });
  group('testing the userRespository', () {
    test('when status code is 200 , user model should be returned',
       () async{
      //arrange
         when(() => mockHttpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1')
         )
         ).thenAnswer((invocation) async{
           return Response(
             '''
              {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
     "website": "hildegard.org"
  }
             '''
           , 200);
         });
      //act
         
      final user = await userRepository.getUser();

      //assert
      expect(user, isA<User>());
       });

    test('checking exception if status code is not 200',
            () async {
      //arrange
       when(() => mockHttpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1')
       )
       ).thenAnswer((invocation) async => Response('{}', 500));
      //act
      final user = userRepository.getUser();
      //assert
      expect(user, throwsException);
    });
  });
}