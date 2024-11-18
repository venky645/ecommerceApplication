import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_detail_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([FireStoreDataBase])
void main()  {
  group('Product Detail Bloc Tests', () {
    late MockFireStoreDataBase mockFireStoreDataBase;
    late ProductDetailBloc productDetailBloc;

    final mockProduct = Product(
      id: 112,
      title: 'Sample Product',
      description: 'This is a sample product description.',
      price: 99.99,
      discountPercentage: 10,
      rating: 4.5,
      stock: 100,
      brand: 'Sample Brand',
      category: 'Sample Category',
      thumbnail: 'https://example.com/thumbnail.jpg',
      images: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
      availabilityStatus: 'In Stock',
      dimension: {
        'height': 10,
        'width': 5,
        'depth': 2,
      },
      metaData: {
        'color': 'Red',
        'material': 'Plastic',
      },
      returnPolicy: '30-day return policy',
      reviews: [
        {'reviewer': 'John', 'rating': 5, 'comment': 'Great product!'},
        {
          'reviewer': 'Jane',
          'rating': 4,
          'comment': 'Good value for money.'
        },
      ],
      shippingInformation: 'Ships within 2-3 business days',
      tags: ['electronics', 'gadgets', 'sale'],
      warrantyInformation: '1-year warranty included',
    );

    final mockReview = {
      'reviewer': 'Jane',
      'rating': 4,
      'comment': 'Good value for money.'
    };

    setUp(() async {
      mockFireStoreDataBase = MockFireStoreDataBase();
      productDetailBloc = ProductDetailBloc(fireStoreDataBase: mockFireStoreDataBase);
    });

    blocTest<ProductDetailBloc,ProductDetailBlocState>(
      'Fetch product by ID success',
      build: () {
        when(mockFireStoreDataBase.getProductById('1'))
            .thenAnswer((_) async => mockProduct);
        return productDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchProduct(productId: '1')),
      expect: () => [
        ProductFetchSuccess(product: mockProduct),
        ProductReviews(reviews: mockProduct.reviews!)
      ],
    );

    blocTest<ProductDetailBloc,ProductDetailBlocState>('Product Fetch failed',
        build:() {
          when(mockFireStoreDataBase.getProductById('1'))
              .thenAnswer((_) async => null);
          return productDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchProduct(productId: '1')),
        expect: () => [
            ProductFetchFailure(error: 'product fetch failed')
    ]
    );

    blocTest<ProductDetailBloc,ProductDetailBlocState>('Review Submission Successful',
        build:() {
          when(mockFireStoreDataBase.submitReview(mockReview,'1'))
              .thenAnswer((_) async => [mockReview]);
          return productDetailBloc;
        },
        act: (bloc) => bloc.add(SubmitReview(review: mockReview, productId: '1',)),
        expect: () => [
          ProductReviews(reviews: [mockReview])
        ]
    );
  });
}
