import 'package:ecommerce_app/presentation/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/presentation/home/home_bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: title == 'All'?Colors.white:Colors.black,
          backgroundColor: title == 'All'?Colors.green:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side:  BorderSide(
              width: 2,
              color: title == 'All'?Colors.green:Colors.black
          )

      ),
      onPressed: (){
        BlocProvider.of<HomeBloc>(context).add(FetchProductsByCategory(category: title));
      },
      child: Text(title),
    );
  }
}

