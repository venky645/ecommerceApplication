import 'dart:math';

import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/presentation/home/home_view.dart';

void main(){

  testWidgets('testing home screen', (widgetTester) async {
    await widgetTester.pumpWidget(
       BlocProvider<HomeBloc>(
           create: (context) => HomeBloc(fireStoreDataBase: FireStoreDataBase()),
       child: MaterialApp(
         home: HomeView()),
       )
    );

    var appBarWidget = find.byType(AppBar);
    expect(appBarWidget, findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    // var items = ['All','laptops','smartphones','fragrances','Women','Men','Automotives','Bikes'];
    // for(var item in items){
    //   expect(find.text(item), findsOneWidget);
    // }
    var sizedBoxWidget  = find.byKey(Key('sizedBoxForSearch'));
    final size = widgetTester.widget<SizedBox>(sizedBoxWidget);

    expect(size.height, 60);
    expect(sizedBoxWidget, findsOneWidget);

    // var filterButton = find.text('All');
    // expect(filterButton, findsOneWidget);
    // await widgetTester.tap(filterButton);
    // await widgetTester.pumpAndSettle();
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // await widgetTester.pumpAndSettle();
    // expect(CircularProgressIndicator(), findsNothing);

    // Tap the 'laptops' FilterButton to trigger loading.
    await widgetTester.tap(find.widgetWithText(OutlinedButton, 'laptops'));
    await widgetTester.pump();





  });
}