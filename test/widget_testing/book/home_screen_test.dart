import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/home_screen.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/display_books.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Screen - ', () {
    testWidgets('Your Book/s text exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: HomeScreen()),
      ));
      final yourBooksTxt = find.text('Your Book/s');
      expect(yourBooksTxt, findsOneWidget);
    });

    testWidgets('Books: text exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: HomeScreen()),
      ));
      final booksTxt = find.text('Books:');
      expect(booksTxt, findsOneWidget);
    });

    testWidgets('Display Books Widget Exist', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookBloc(),
        child: const MaterialApp(home: HomeScreen()),
      ));
      final displayBooks = find.byType(DisplayBooks);
      expect(displayBooks, findsOneWidget);
    });
  });
}
