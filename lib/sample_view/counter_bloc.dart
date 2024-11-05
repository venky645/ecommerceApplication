import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is CounterIncrementEvent) {
      yield state + 1;
    } else if (event is CounterDecrementEvent) {
      yield state - 1;
    }
  }
}