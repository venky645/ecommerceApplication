abstract class HomeEvent{
}

class FetchAllProducts extends HomeEvent {}

class FetchProductsByCategory extends HomeEvent{
   String category;
  FetchProductsByCategory({required this.category});
}
