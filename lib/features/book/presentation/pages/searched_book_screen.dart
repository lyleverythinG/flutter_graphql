import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_button.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/pages/edit_book_info_screen.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/profile_circle_avatar.dart';

class SearchedBookScreen extends StatelessWidget {
  final int bookIndex;
  final BookModel bookModel;
  final bool? isFromHomeSearch;
  const SearchedBookScreen(
      {Key? key,
      required this.bookModel,
      required this.bookIndex,
      this.isFromHomeSearch = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Constants.kWhite,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: 'Profile Picture'.toUpperCase(),
            ),
            const ProfileCircleAvatar(),
            CustomText(text: 'Author Name:.'.toUpperCase()),
            CustomText(text: bookModel.author),
            CustomText(text: 'Book Title:'.toUpperCase()),
            CustomText(text: bookModel.title),
            CustomText(text: 'Book Published:'.toUpperCase()),
            CustomText(text: bookModel.year.toString()),
            if (isFromHomeSearch == true)
              CustomElevatedButton(
                text: 'Update Doctor Information'.toUpperCase(),
                fontWeight: FontWeight.bold,
                fontSize: 16,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditBookInfoScreen(
                              bookIndex: bookIndex,
                              bookModel: bookModel,
                              isWhiteAppBar: true)));
                },
              ),
          ],
        ),
      ),
    );
  }
}
