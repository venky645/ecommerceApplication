import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/presentation/product_detail/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/product_detail_bloc/product_detail_event.dart';

class ReviewsSection extends StatefulWidget {
  final List<dynamic>? reviews;
  final String productId;
  ReviewsSection({super.key, required this.reviews, required this.productId});

  @override
  _ReviewsSectionState createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailBlocState>(
      buildWhen: (previous, current) => current is ProductReviews,
      builder: (context, state) {
        if (state is ProductReviews) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...state.reviews.map((review) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: review['rating'].toDouble(),
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        itemCount: 5,
                        itemSize: 30.0,
                        unratedColor: Colors.grey[300],
                      ),

                      // Row(
                      //   children:
                      //    List.generate(
                      //     review['rating'],
                      //     (index) => Icon(Icons.star, color: Colors.amber),
                      //   ),
                      // ),

                      Text(
                        review['comment'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '- ${review['reviewerEmail']}, ${review['date'].substring(0, 10)}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              // Submit review form
              Text(
                'Submit a Review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rating',
                style: TextStyle(fontSize: 16),
              ),

              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
                itemSize: 40.0,
                unratedColor: Colors.grey[300],
                glow: true,
                glowColor: Colors.amber.withOpacity(0.5),
                ignoreGestures: false,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(Colors.amber)),
                  onPressed: () async {
                    String? emailId = FirebaseAuth.instance.currentUser!.email;
                    if (_commentController.text.isNotEmpty || _rating != 0) {
                      final newReview = {
                        "comment": _commentController.text,
                        "date": DateTime.now().toIso8601String(),
                        "rating": _rating,
                        "reviewerEmail": emailId,
                        "reviewerName":
                            FirebaseAuth.instance.currentUser?.displayName,
                      };
                      _commentController.clear();
                      context.read<ProductDetailBloc>().add(SubmitReview(
                          review: newReview, productId: widget.productId));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please enter a comment and rating')),
                      );
                    }
                  },
                  child: Text('Submit Review'),
                ),
              ),
              SizedBox(height: 10)
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
