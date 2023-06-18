part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class LoadingState extends BookState {
  const LoadingState();
}

class BookUpdatedMsg extends BookState {
  const BookUpdatedMsg();
}

class BookUpdated extends BookState {
  final List<BookModel> books;

  const BookUpdated({required this.books});

  @override
  List<Object> get props => [books];
}
