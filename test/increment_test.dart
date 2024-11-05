import 'package:ecommerce_app/utils/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late Counter counter;
  setUp(() {
   counter = Counter();
  });
  group('testing the increment logic', () {

    test('description of intialized value is equal to zero', () {
      final value  = counter.value;
      expect(value, 0);
    });

    test('increment', () {
      counter.increment();
      final value  = counter.value;
      expect(value, 1);
    });

    test('decrement', () {

      counter.increment();
      counter.increment();

      counter.decrement();

      final value  = counter.value;


      expect(value, 1);

    });
    
    test('reset', () {
      counter.reset();
      final int value = counter.value;
      expect(value, 0);
    });
  });
}