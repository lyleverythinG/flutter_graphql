import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String? id;
  final String author;
  final String title;
  final int year;
  const BookCard(
      {Key? key,
      this.id,
      required this.author,
      required this.title,
      required this.year})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.blueAccent,
      elevation: 3,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          author,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    Text(
                      title,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Year: ',
                        ),
                        Text(year.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
