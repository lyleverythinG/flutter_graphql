import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/edit_book_info_screen.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/book_card.dart';

class DisplayBooks extends StatelessWidget {
  const DisplayBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookInitial) {
          // fetch books from API.
          context.read<BookBloc>().add(const GetBooksFromAPI());
        }
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BookUpdated) {
          if (state.books.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.books.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => EditBookInfoScreen(
                            bookIndex: index,
                            bookModel: state.books[index],
                          ),
                        ),
                      );
                    },
                    child: BookCard(
                        author: state.books[index].author,
                        title: state.books[index].title,
                        year: state.books[index].year),
                  );
                }),
              ),
            );
          }
          return const Expanded(
            child: Center(child: CustomText(text: 'Add Book')),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
