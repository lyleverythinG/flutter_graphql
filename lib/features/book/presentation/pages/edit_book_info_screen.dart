import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/core/constants/constants.dart';
import 'package:flutter_graphql/core/reusables/custom_button.dart';
import 'package:flutter_graphql/core/reusables/custom_text.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:flutter_graphql/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_graphql/features/book/presentation/widgets/provide_book_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditBookInfoScreen extends StatefulWidget {
  final BookModel bookModel;
  final int bookIndex;
  final bool isWhiteAppBar;
  const EditBookInfoScreen({
    Key? key,
    required this.bookModel,
    required this.bookIndex,
    this.isWhiteAppBar = false,
  }) : super(key: key);

  @override
  State<EditBookInfoScreen> createState() => _EditBookInfoScreenState();
}

class _EditBookInfoScreenState extends State<EditBookInfoScreen> {
  late final bookAuthorNameC = TextEditingController();
  late final bookTitleC = TextEditingController();
  late final bookPublishedC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.bookModel.id != null) {
      bookAuthorNameC.text = widget.bookModel.author;
      bookTitleC.text = widget.bookModel.title;
      bookPublishedC.text = widget.bookModel.year.toString();
    }
  }

  @override
  void dispose() {
    bookAuthorNameC.dispose();
    bookTitleC.dispose();
    bookPublishedC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: widget.isWhiteAppBar
            ? Constants
                .kWhite // Used white app bar if coming from search bar for uniformity of colors.
            : null,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
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
                      const CustomText(
                          text: 'Please Fill - Up Book Information:'),
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
                        textInputType: TextInputType.number,
                        hintText: 'Enter Book Title',
                        errorText: 'Please enter Book Title',
                      ),
                      Constants.gapH4,
                      const Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(text: 'Book Published:')),
                      ProvideBookInfo(
                        controller: bookPublishedC,
                        textInputType: TextInputType.number,
                        hintText: 'Enter Year',
                        errorText: 'Please enter Year Published',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      BlocListener<BookBloc, BookState>(
                        listener: (context, state) {
                          if (state is BookUpdated) {
                            Fluttertoast.showToast(
                              msg: 'Successfully updated book information.',
                            );
                            if (widget.isWhiteAppBar) {
                              int count = 0;
                              // Pop 3 times after updating doctor info if update is coming from search bar home screen.
                              Navigator.popUntil(
                                  context, (route) => count++ == 3);
                            }
                          }
                        },
                        child: CustomElevatedButton(
                          text: 'Update Book Info',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<BookBloc>().add(
                                    UpdateBookEvent(
                                      bookIndex: widget.bookIndex,
                                      book: BookModel(
                                          id: widget.bookModel.id,
                                          author: bookAuthorNameC.text,
                                          title: bookTitleC.text,
                                          year: int.parse(bookPublishedC.text)),
                                    ),
                                  );
                              // Hides keyboard upon updating book info.
                              FocusManager.instance.primaryFocus?.unfocus();
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
        ),
      ),
    );
  }
}
