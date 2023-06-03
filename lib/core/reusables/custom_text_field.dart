import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  // ignore: use_key_in_widget_constructors
  const CustomTextField({
    this.controller,
    this.data,
    this.hintText,
    this.keyboardType,
    required this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.kWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        onChanged: onChanged,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: Constants.kBlackBorderDecoration,
          prefixIcon: Icon(
            data,
            color: Constants.kBlack87,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
