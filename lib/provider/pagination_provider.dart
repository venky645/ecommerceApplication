import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider extends StateNotifier<int> {
  PaginationProvider() : super(1);

  void setPageNumber(int pageNumber) {
    state = pageNumber;
  }

  void increment() {
    state++;
  }

  void decrementPage() {
    state--;
  }
}

final paginationProvider = StateNotifierProvider<PaginationProvider, int>(
      (ref) => PaginationProvider(),
);
