import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../mediaQuery/mediaquery_helper.dart';
class TextFieldWidget extends StatelessWidget {
  final String textFieldTitle;
  final TextEditingController textEditingController;

   const TextFieldWidget({super.key, required this.textFieldTitle, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textFieldTitle,style: const TextStyle(fontWeight:FontWeight.w500)),
        SizedBox(height: mediaQueryHelper.responsiveHeight(context, 10)),
        TextField(
          keyboardType:textFieldTitle == Constants.email?TextInputType.visiblePassword:TextInputType.emailAddress,
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            hintText: textFieldTitle,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.lock_outline,color: Colors.grey,),
            suffixIcon:textFieldTitle == Constants.password ? const Icon(Icons.visibility_off_outlined,color: Colors.grey) : null,
            fillColor: const Color(0xFFF9F5F4),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),

      ],
    );
  }
}
