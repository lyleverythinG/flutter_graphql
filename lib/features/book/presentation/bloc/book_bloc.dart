import 'dart:developer' as developer;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/data/repository/book_repo.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    List<BookModel> books = [];

    on<GetBooksFromAPI>((event, emit) async {
      // Get Books Event
      try {
        emit(const LoadingState());
        books = await BookRepo.getBooks(limit: 5);
        emit(BookUpdated(books: books));
      } catch (e) {
        developer.log('Error getting book/s: $e', name: 'GetBooksError');
      }
    });

    on<AddBookEvent>((event, emit) async {
      // Add Book Event
      try {
        emit(const LoadingState());
        final isBookAdded = await BookRepo.createBook(
            author: event.bookInfo.author,
            title: event.bookInfo.title,
            year: event.bookInfo.year);

        // Inserts the newly added book to the end of the list.
        if (isBookAdded) {
          books.add(event.bookInfo);
        }
        emit(BookUpdated(books: books));
      } catch (e) {
        developer.log('Error adding book: $e', name: 'AddingBook');
      }
    });
  }
}
