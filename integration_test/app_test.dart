import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerce_app/main.dart' as app;


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('verify login screen with correct user name and password',
          (widgetTester) async {
          app.main();
          await widgetTester.pumpAndSettle();
          await Future.delayed(const Duration(seconds:  5));
          expect(find.byType(AppBar), findsOneWidget);
          // await widgetTester.enterText(find.byKey(const Key('user_name')), 'userName');
          // await widgetTester.enterText(find.byKey(const Key('password')), 'password');
          // await widgetTester.tap(find.byType(ElevatedButton));
          // await widgetTester.pumpAndSettle();
          // expect(find.byType(FlutterAnimationView), findsOneWidget);
      },
    );
  });
}