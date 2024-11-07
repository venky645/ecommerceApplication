import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {super.key,
      required this.hintText,
      required this.icon_data,
      this.function,
      required this.controller});
  final String hintText;
  final IconData icon_data;
  final Function? function;
  final TextEditingController controller;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon_data,
            color: Color.fromARGB(255, 91, 155, 207),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
