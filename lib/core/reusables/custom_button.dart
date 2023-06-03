import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomElevatedButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.fontSize,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: Constants.kWhite,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Constants.kBlueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
    );
  }
}
