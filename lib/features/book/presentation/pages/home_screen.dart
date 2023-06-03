import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/display_books.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: const [
          CustomText(
            text: "Your Book/s",
            fontSize: 21,
          ),
          Constants.gapH24,
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: "Books:",
              fontSize: 20,
            ),
          ),
          Constants.gapH10,
          DisplayBooks(),
        ],
      ),
    );
  }
}
