import 'package:hive/hive.dart';

class BookModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String author;

  @HiveField(2)
  String title;

  @HiveField(3)
  int year;

  BookModel({
    this.id,
    required this.author,
    required this.title,
    required this.year,
  });

  static BookModel fromMap({required Map map}) => BookModel(
        id: map['_id'],
        author: map['author'],
        title: map['title'],
        year: map['year'],
      );
}
