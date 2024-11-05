import 'package:ecommerce_app/testing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestingView extends ConsumerStatefulWidget {
  const TestingView({super.key});

  @override
  ConsumerState<TestingView> createState() => _TestingViewState();
}

class _TestingViewState extends ConsumerState<TestingView> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count'),
            ElevatedButton(
              key: Key('elevatedButton_for_increment_counter'),
              onPressed: () {
                ref
                    .read(counterProvider.notifier)
                    .state++; // Access state to update
              },
              child: const Text('Increment Counter'),
            ),
            Text('42')
          ],
        ),
      ),
    );
  }
}
