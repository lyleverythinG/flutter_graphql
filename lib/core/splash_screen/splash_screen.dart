import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/pages/home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (c) => BlocProvider(
                    create: (context) =>
                        BookBloc()..add(const GetBooksFromAPI()),
                    child: const Home(),
                  )));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Lottie.asset(
            'assets/splash_book.json',
            repeat: false,
          ),
        ),
      ),
    );
  }
}
