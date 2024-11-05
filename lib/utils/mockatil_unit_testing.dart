import 'package:ecommerce_app/utils/repository_unit.dart';
import 'package:ecommerce_app/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DummyViewForUnitTesting extends StatefulWidget {
  const DummyViewForUnitTesting({super.key});

  @override
  State<DummyViewForUnitTesting> createState() => _DummyViewForUnitTestingState();
}

class _DummyViewForUnitTestingState extends State<DummyViewForUnitTesting> {
  Future<User> getUsers = UserRepository(Client()).getUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUsers,
        builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());
           }
           return Center(
             child:  Text(
               '${snapshot.data?.email}'
             ),
           );
        },

      ),
    );
  }
}
