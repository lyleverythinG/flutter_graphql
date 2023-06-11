import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/constants/constants.dart';

class ProfileCircleAvatar extends StatelessWidget {
  const ProfileCircleAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.20,
        backgroundColor: Constants.kWhite,
        backgroundImage: const AssetImage('assets/book_img.png'),
      ),
    );
  }
}
