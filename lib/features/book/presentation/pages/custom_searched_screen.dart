import 'package:flutter/material.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/search_delegate_listview.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<BookModel> listOfBooks;
  final bool? isFromHomeSearch;
  CustomSearchDelegate(
      {required this.listOfBooks, this.isFromHomeSearch = true});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => 'query',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          // Closes the search page and opens back the original page.
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // The results shown after the user submits a search.
    List<BookModel> matchedKeyword = [];
    for (var book in listOfBooks) {
      // Searched bar checks for matching author, title or book year.
      if (book.author.toLowerCase().contains(query.toLowerCase()) ||
          book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.year.toString().contains(query)) {
        matchedKeyword.add(book);
      }
    }
    return SearchDelegateListView(
        isFromHomeSearch: isFromHomeSearch,
        listOfBooks: listOfBooks,
        matchedKeyword: matchedKeyword);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BookModel> matchedKeyword = [];
    for (var book in listOfBooks) {
      // Condition checks for matching author, title or book year.
      if (book.author.toLowerCase().contains(query.toLowerCase()) ||
          book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.year.toString().contains(query)) {
        matchedKeyword.add(book);
      }
    }
    return SearchDelegateListView(
      listOfBooks: listOfBooks,
      matchedKeyword: matchedKeyword,
      isFromHomeSearch: isFromHomeSearch,
    );
  }
}
