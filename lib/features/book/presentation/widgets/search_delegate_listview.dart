import 'package:flutter/material.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/pages/searched_book_screen.dart';

class SearchDelegateListView extends StatelessWidget {
  final List<BookModel> listOfBooks;
  final List<BookModel> matchedKeyword;
  final bool? isFromHomeSearch;
  const SearchDelegateListView(
      {Key? key,
      required this.listOfBooks,
      required this.matchedKeyword,
      this.isFromHomeSearch = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matchedKeyword.length,
      itemBuilder: ((context, index) {
        // Specific book from the list of books
        var specificBook = matchedKeyword[index];
        return ListTile(
          leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/book_img.png'),
              ),
            ),
          ),
          title: Text(specificBook.author),
          subtitle: Text(specificBook.title),
          onTap: () {
            // Closes the keyboard when navigating to other screen to avoid overflows
            FocusManager.instance.primaryFocus?.unfocus();
            // The index/pos of the current book in the actual books list from book bloc.
            int bookIndex = listOfBooks.indexOf(specificBook);
            //TODO: Routes to the searched book info screen when user taps.
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => SearchedBookScreen(
                          isFromHomeSearch: isFromHomeSearch,
                          bookIndex: bookIndex,
                          bookModel: matchedKeyword[index],
                        )));
          },
        );
      }),
    );
  }
}
