import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/db/remote/firestore_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_event.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_view_tests.mocks.dart';

@GenerateMocks([FireStoreDataBase])
main(){
  late HomeBloc homeBloc;
  late MockFireStoreDataBase mockFireStoreDataBase;
  setUp(() {
    mockFireStoreDataBase = MockFireStoreDataBase();
    homeBloc = HomeBloc(fireStoreDataBase: mockFireStoreDataBase);
  });
  tearDown(() {
    homeBloc.close();
  });

  final mockProducts = [Product(
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
  )];

  blocTest<HomeBloc,HomeState>('Product detail Fetch Success',
      build: () {
        when(mockFireStoreDataBase.getAllProducts()).thenAnswer((realInvocation) async {
          return mockProducts;
        });
        return homeBloc;
      },
    act: (bloc) => homeBloc.add(FetchAllProducts()),
    expect: () => [
      ProductsLoading(),
      ProductsSuccess(mockProducts)
    ],

  );

  blocTest<HomeBloc,HomeState>('no products found',
    build: () {
      when(mockFireStoreDataBase.getAllProducts()).thenAnswer((realInvocation) async {
        return [];
      });
      return homeBloc;
    },
    act: (bloc) => homeBloc.add(FetchAllProducts()),
    expect: () => [
      ProductsLoading(),
      ProductsError('no products are found')
    ],

  );

  // blocTest<HomeBloc,HomeState>('Exception occured while fetching products',
  //   build: () {
  //     when(mockFireStoreDataBase.getAllProducts()).thenAnswer((realInvocation) async {
  //       return null;
  //     });
  //     return homeBloc;
  //   },
  //   act: (bloc) => homeBloc.add(FetchAllProducts()),
  //   expect: () => [
  //     ProductsLoading(),
  //     ProductsError('no products are found')
  //   ],
  //
  // );


  blocTest<HomeBloc,HomeState>('category product fetch',
    build: () {
      when(mockFireStoreDataBase.getProductsByCatergory('Beauty')).thenAnswer((realInvocation) async {
        return mockProducts;
      });
      return homeBloc;
    },
    act: (bloc) => homeBloc.add(FetchProductsByCategory(category: 'Beauty')),
    expect: () => [
      ProductsLoading(),
      ProductsSuccess(mockProducts)
    ],

  );


  //need to write exception test cases in this file

}