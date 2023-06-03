import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/reusables/custom_text_field.dart';

class ProvideBookInfo extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final TextInputType? textInputType;
  final IconData? iconData;
  const ProvideBookInfo(
      {Key? key,
      required this.controller,
      this.iconData,
      required this.hintText,
      required this.errorText,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      keyboardType: textInputType ?? TextInputType.name,
      data: iconData ?? Icons.person,
      hintText: hintText,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
