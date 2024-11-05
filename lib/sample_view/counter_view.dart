import 'package:ecommerce_app/sample_view/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Bloc Counter'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$state',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<CounterBloc>(context).add(CounterIncrementEvent());

                      },
                      child: const Text('Increment'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(CounterDecrementEvent());
                      },
                      child: const Text('Decrement'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}