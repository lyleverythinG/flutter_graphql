import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/edit_book_info_screen.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/add_book_text.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/book_card.dart';

class DisplayBooks extends StatelessWidget {
  const DisplayBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
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
                  return Dismissible(
                    key: Key(state.books[index].id!),
                    background: Constants.dismissibleContainer,
                    onDismissed: (direction) {
                      context.read<BookBloc>().add(DeleteBookEvent(
                          bookIndex: index, bookId: state.books[index].id!));
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (c) => BlocProvider(
                              create: (context) =>
                                  BookBloc()..add(GetBooks(books: state.books)),
                              child: EditBookInfoScreen(
                                bookIndex: index,
                                bookModel: state.books[index],
                              ),
                            ),
                          ),
                        );
                      },
                      child: BookCard(
                          author: state.books[index].author,
                          title: state.books[index].title,
                          year: state.books[index].year),
                    ),
                  );
                }),
              ),
            );
          }
          return const AddBookText();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
