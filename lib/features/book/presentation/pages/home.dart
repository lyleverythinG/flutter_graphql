import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/add_book_screen.dart';
import 'package:flutter_graphql/features/book/presentation/pages/custom_searched_screen.dart';
import 'package:flutter_graphql/features/book/presentation/pages/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<BookModel> books = [];
  final List<Widget> screens = [
    const HomeScreen(),
    const AddBookScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final bookState = context.watch<BookBloc>().state;
    if (bookState is BookUpdated) {
      books = bookState.books;
    }
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
            text: 'Home', color: Constants.kWhite, fontSize: 20),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(listOfBooks: books));
            },
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Constants.kBlueAccent,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedItemColor: Constants.kBlack87,
        items: Constants.kBottomNavigationBarItems,
      ),
    );
  }
}
