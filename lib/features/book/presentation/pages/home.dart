import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/features/book/presentation/pages/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int _currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {},
        backgroundColor: Constants.kBlueAccent,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedItemColor: Constants.kBlack87,
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book),
              label: "Books",
              tooltip: 'Books'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bookMedical),
              label: "Add Books",
              tooltip: 'Add Books'),
        ],
      ),
    );
  }
}
