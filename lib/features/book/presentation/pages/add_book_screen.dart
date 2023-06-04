import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_button.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/provide_book_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final bookAuthorNameC = TextEditingController();
  final bookTitleC = TextEditingController();
  final bookYearC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void clearFieldsAfterAdding() {
    bookAuthorNameC.clear();
    bookTitleC.clear();
    bookYearC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CustomText(text: 'Please Fill - Up Book Information:'),
                  Constants.gapH16,
                  const Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(text: 'Author Name:')),
                  ProvideBookInfo(
                    controller: bookAuthorNameC,
                    hintText: 'Enter Author Name',
                    errorText: 'Please enter Author Name',
                  ),
                  Constants.gapH4,
                  const Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(text: 'Book Title:')),
                  ProvideBookInfo(
                    controller: bookTitleC,
                    hintText: 'Enter Book Title',
                    errorText: 'Please enter Book Title',
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(text: 'Book Published:')),
                  ProvideBookInfo(
                    controller: bookYearC,
                    textInputType: TextInputType.number,
                    hintText: 'Enter Year',
                    errorText: 'Please enter Year Published',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  BlocListener<BookBloc, BookState>(
                    listener: (context, state) {
                      if (state is BookUpdated) {
                        Fluttertoast.showToast(
                          msg: 'Successfully Added Book',
                        );
                        // Clearing fields after adding successfully.
                        clearFieldsAfterAdding();
                      }
                    },
                    child: CustomElevatedButton(
                      text: 'Add Book',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<BookBloc>().add(AddBookEvent(
                              bookInfo: BookModel(
                                  author: bookAuthorNameC.text.trim(),
                                  title: bookTitleC.text.trim(),
                                  year: int.parse(bookYearC.text))));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
