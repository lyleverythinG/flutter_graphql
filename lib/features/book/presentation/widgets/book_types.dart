import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/book_type_image.dart';

class BookTypeOptions extends StatelessWidget {
  const BookTypeOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BookTypeIcon> bookTypeIcon = [
      BookTypeIcon(bookType: "History", icon: 'assets/book_history.png'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(bookTypeIcon.length, (index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: BookTypeImage(
                bookTypeIcon: bookTypeIcon[index].icon,
              ),
            ),
            Constants.gapH4,
            CustomText(
              text: bookTypeIcon[index].bookType,
            )
          ],
        );
      }),
    );
  }
}

class BookTypeIcon {
  final String bookType;
  final String icon;
  BookTypeIcon({
    required this.bookType,
    required this.icon,
  });
}
