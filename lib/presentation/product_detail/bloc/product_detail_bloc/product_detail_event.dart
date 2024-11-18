import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
  @override
  List<Object?> get props => [];
}

class FetchProduct extends ProductDetailEvent {
  final String productId;
  const FetchProduct({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class SubmitReview extends ProductDetailEvent {
  final Map<String, dynamic> review;
  final String productId;
  const SubmitReview({required this.review, required this.productId});
  @override
  List<Object?> get props => [review];
}