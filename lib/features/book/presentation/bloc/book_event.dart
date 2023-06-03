part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class GetBooksFromAPI extends BookEvent {
  const GetBooksFromAPI();
  @override
  List<Object> get props => [];
}

class AddBookEvent extends BookEvent {
  final BookModel bookInfo;

  const AddBookEvent({required this.bookInfo});
  @override
  List<Object> get props => [bookInfo];
}

class BookUpdate extends BookEvent {
  final List<BookModel> books;
  const BookUpdate({required this.books});
  @override
  List<Object> get props => [books];
}
