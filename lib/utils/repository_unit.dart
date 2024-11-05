import 'package:ecommerce_app/utils/user.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  final http.Client client;
  UserRepository(this.client);
  Future<User> getUser() async{
    final response =  await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

    if(response.statusCode == 200){
        return User.fromJson(response.body);
    }
    throw Exception('some error');

  }
}