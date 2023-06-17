import 'dart:developer' as developer;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/data/repository/book_repo.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        final bookId = await BookRepo.createBook(
            author: event.bookInfo.author,
            title: event.bookInfo.title,
            year: event.bookInfo.year);

        // Inserts the newly added book to the end of the list.
        debugPrint('bookId $bookId');
        if (bookId != null) {
          BookModel currentBook = BookModel(
              id: bookId,
              author: event.bookInfo.author,
              title: event.bookInfo.title,
              year: event.bookInfo.year);
          books.add(currentBook);
        }
        emit(BookUpdated(books: books));
      } catch (e) {
        developer.log('Error adding book: $e', name: 'AddingBookError');
      }
    });

    on<UpdateBookEvent>((event, emit) async {
      // Update Book Event
      try {
        emit(const LoadingState());
        await BookRepo.updateBook(
          bookModel: event.book,
        );

        // Updates the current book info.
        books[event.bookIndex] = event.book;
        emit(BookUpdated(books: books));
      } catch (e) {
        developer.log('Error Updating Book Info: $e',
            name: 'UpdatingBookError');
      }
    });

    on<DeleteBookEvent>((event, emit) async {
      // Delete Book Event
      try {
        emit(const LoadingState());
        bool isBookDeleted = await BookRepo.deleteBook(
          id: event.bookId,
        );

        // Updates the current book info.
        if (isBookDeleted) {
          books.removeAt(event.bookIndex);
          Fluttertoast.showToast(msg: 'deleted successfully');
        }
        emit(BookUpdated(books: books));
      } catch (e) {
        developer.log('Error Updating Book Info: $e',
            name: 'UpdatingBookError');
      }
    });
  }
}
