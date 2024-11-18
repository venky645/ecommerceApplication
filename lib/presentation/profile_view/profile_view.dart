import 'package:ecommerce_app/presentation/auth_screens/login_view.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_cubit.dart';
import 'package:ecommerce_app/presentation/profile_view/bloc/profile_state.dart';
import 'package:ecommerce_app/presentation/profile_view/widgets/profile_card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).fetchUserDetails();
    return Scaffold(
      backgroundColor: const Color(0xF5F9F9F5),
      appBar: AppBar(
        backgroundColor: const Color(0xF5F9F9F5),
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                  child: Icon(Icons.person),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )))
              ],
            ),
            Text('Venkatesh Dudala'),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Text(state.email);
              },
            ),
            ElevatedButton(onPressed: (){}, child: Text('edit profile')),
            Divider(
              endIndent: 20,
              indent: 20,
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProfileCardView(title: 'Order History', icon: Icons.history),
                  ProfileCardView(title: 'Wish List', icon: Icons.history),
                  ProfileCardView(title: 'Payments', icon: Icons.history),
                  ProfileCardView(title: 'About', icon: Icons.history)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                          (route) => false));
                },
                child: Text('Logout')),
            SizedBox(
              height: 100,
            ),
            Text('version : 1.0.0')
          ],
        ),
      ),
    );
  }
}
