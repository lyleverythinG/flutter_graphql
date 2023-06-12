import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home - ', () {
    testWidgets('Home Text exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: Home()),
      ));
      final homeTxt = find.text('Home');
      expect(homeTxt, findsOneWidget);
    });

    testWidgets('Appbar exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: Home()),
      ));
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);
    });

    testWidgets('Bottom navigation bar exists', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: Home()),
      ));
      final bottomNavBar = find.byType(BottomNavigationBar);
      expect(bottomNavBar, findsOneWidget);
    });

    testWidgets('Search bar icon exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: Home()),
      ));
      final searchIcon = find.byIcon(Icons.search);
      expect(searchIcon, findsOneWidget);
    });
  });
}
