import 'package:flutter/material.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/book_card.dart';

class DisplayBooks extends StatelessWidget {
  const DisplayBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: ((context, index) {
          return const BookCard(
              author: 'Juan Dela Cruz',
              title: 'Ang Pagbabalik Ni Juan',
              year: 2023);
        }),
      ),
    );
  }
}
