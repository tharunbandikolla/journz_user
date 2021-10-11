import 'package:firebase_auth/firebase_auth.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowBookMarkInHomeScreen extends StatelessWidget {
  String bookmarkId;
  ArticlesModel model;
  ShowBookMarkInHomeScreen(
      {Key? key, required this.bookmarkId, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkCubit = BlocProvider.of<BookmarkCubit>(context);
    if (FirebaseAuth.instance.currentUser != null) {
      bookmarkCubit.checkBookmarked(
          FirebaseAuth.instance.currentUser!.uid, this.bookmarkId);
    }

    return BlocBuilder<BookmarkCubit, BookmarkcubitState>(
      builder: (context, state) {
        //print('nnn hp ${state.isBookmarked}');
        return state.isBookmarked
            ? Icon(Icons.bookmark)
            : Icon(Icons.bookmark_border);
      },
    );
  }
}
