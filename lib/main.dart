import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/splash_screen/splash_screen.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/local_storage_adaptor/user_adaptor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookModelAdapter());
  await Hive.openBox<BookModel>('booksBox');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book App',
        theme: Constants.aTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
