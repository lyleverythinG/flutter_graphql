import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';

class AddBookText extends StatelessWidget {
  const AddBookText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
          child: CustomText(
        text: 'Add Book',
        fontSize: 20,
      )),
    );
  }
}
