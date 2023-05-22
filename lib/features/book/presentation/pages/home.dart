import 'package:flutter/material.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              BookCard(author: 'test author', title: 'test title', year: 2023),
            ],
          ),
        ),
      ),
    );
  }
}
