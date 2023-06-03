import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';

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
      color: Constants.kBlueAccent,
      elevation: 3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        CustomText(
                          text: author,
                        ),
                      ],
                    ),
                    CustomText(
                      text: title,
                    ),
                    Row(
                      children: [
                        const CustomText(
                          text: 'Year: ',
                        ),
                        CustomText(text: year.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              Container(
                height: 100,
                width: 100,
                decoration:
                    const BoxDecoration(image: Constants.bookDecorationImg),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
