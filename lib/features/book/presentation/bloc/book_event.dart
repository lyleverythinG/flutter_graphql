part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class GetBooksFromAPI extends BookEvent {
  const GetBooksFromAPI();
  @override
  List<Object> get props => [];
}

class GetBooks extends BookEvent {
  final List<BookModel> books;
  const GetBooks({required this.books});
  @override
  List<Object> get props => [books];
}

class AddBookEvent extends BookEvent {
  final BookModel bookInfo;

  const AddBookEvent({required this.bookInfo});
  @override
  List<Object> get props => [bookInfo];
}

class UpdateBookEvent extends BookEvent {
  final int bookIndex;
  final BookModel book;
  const UpdateBookEvent({
    required this.book,
    required this.bookIndex,
  });
  @override
  List<Object> get props => [book, bookIndex];
}

class DeleteBookEvent extends BookEvent {
  final int bookIndex;
  final String bookId;
  const DeleteBookEvent({
    required this.bookId,
    required this.bookIndex,
  });
  @override
  List<Object> get props => [bookId, bookIndex];
}
