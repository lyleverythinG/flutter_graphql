import 'package:flutter/material.dart';

class BookTypeImage extends StatelessWidget {
  final String bookTypeIcon;
  const BookTypeImage({Key? key, required this.bookTypeIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        bookTypeIcon,
      ),
    );
  }
}
