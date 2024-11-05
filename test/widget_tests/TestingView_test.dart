
import 'package:ecommerce_app/TestingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets("testing the testViewPage", (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
            home: TestingView()),
      )
    );

    expect(find.text('42'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await widgetTester.tap(find.byKey(Key('elevatedButton_for_increment_counter')));
    await widgetTester.pump();
    expect(find.text('1'), findsOneWidget);

    var widget = find.byType(Scaffold);
    expect(widget, findsOneWidget);

  });
}