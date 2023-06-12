import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:hive/hive.dart';

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0; // Type id should be unique.

  @override
  BookModel read(BinaryReader reader) {
    return BookModel(
      id: reader.read(),
      author: reader.read(),
      title: reader.read(),
      year: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer.write(obj.id);
    writer.write(obj.author);
    writer.write(obj.title);
    writer.write(obj.year);
  }
}
