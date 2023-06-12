import 'dart:developer' as developer;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/data/repository/book_repo.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    List<BookModel> books = [];
    final booksBox = Hive.box<BookModel>('booksBox');

    on<GetBooksFromAPI>((event, emit) async {
      // Get Books Event
      try {
        emit(const LoadingState());

        // Gets the list of books from the API if the box is empty, else retrieve and assign it.
        books = booksBox.isEmpty
            ? await BookRepo.getBooks()
            : booksBox.values.toList();

        // If not empty, adds the list of books from API to the box if it's not yet added.
        if (booksBox.isEmpty && books.isNotEmpty) {
          for (BookModel book in books) {
            booksBox.put(book.id, book);
          }
        }

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

        if (bookId != null) {
          BookModel currentBook = BookModel(
              id: bookId,
              author: event.bookInfo.author,
              title: event.bookInfo.title,
              year: event.bookInfo.year);

          // Adds the object to the end of the list.
          books.add(currentBook);

          // Saves the object to the box with the bookId as the key.
          await booksBox.put(bookId, currentBook);
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

        // Updates the current object.
        books[event.bookIndex] = event.book;

        // Updates the current object in the box.
        await booksBox.put(event.book.id, event.book);

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

        if (isBookDeleted) {
          // Removes the object from the list using the index.
          books.removeAt(event.bookIndex);

          // Deletes the object using the key.
          booksBox.delete(event.bookId);
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
