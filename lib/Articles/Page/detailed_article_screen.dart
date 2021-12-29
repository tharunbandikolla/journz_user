import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Articles/Comments/code_articles_comment_model.dart';
import 'package:journz_web/Articles/Comments/hive_articles_comments.dart';
import 'package:journz_web/Articles/Components/article_body_right_pane.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/HiveArticlesModel/LocalArticleModel/code_article_model.dart';

import 'package:journz_web/NewHomePage/Components/home_page_body_right_pane.dart';
import 'package:journz_web/NewHomePage/Components/home_page_footer.dart';
import 'package:journz_web/NewHomePage/Components/home_page_header.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailedArticleScreen extends StatefulWidget {
  final HiveArticleData? data;
  final docId;
  const DetailedArticleScreen({Key? key, this.data, this.docId})
      : super(key: key);

  @override
  _DetailedArticleScreenState createState() => _DetailedArticleScreenState();
}

class _DetailedArticleScreenState extends State<DetailedArticleScreen> {
  CodeArticleData streamData = CodeArticleData();
  @override
  void didChangeDependencies() {
    checkConnection();
    super.didChangeDependencies();
  }

  checkConnection() async {
    ConnectivityResult event = await Connectivity().checkConnectivity();
    if (event != ConnectivityResult.none) {
      listenArticlesData();
      increaseArticleViews();
      listenForComments();
    }
  }

  listenArticlesData() {
    if (widget.data != null) {
      var k = widget.data!.key;
      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          .doc(widget.docId)
          .snapshots()
          .listen((event) {
        if (event.exists) {
          streamData = CodeArticleData.fromJson(event);

          final newArticleData = HiveArticleData()
            ..articleTitle = streamData.articleTitle
            ..articleDescription = streamData.articleDescription!
            ..articleLike = streamData.articleLike!
            ..articlePhotoUrl = streamData.articlePhotoUrl!
            ..articleSubtype = streamData.articleSubtype
            ..authorName = streamData.authorName
            ..authorUid = streamData.authorUid
            ..bookmarkedBy = streamData.bookmarkedBy!
            ..country = streamData.country!
            ..documentId = streamData.documentId!
            ..galleryImages = streamData.galleryImages!
            ..isArticlePublished = streamData.isArticlePublished!
            ..isArticleReported = streamData.isArticleReported!
            ..noOfComments = streamData.noOfComments!
            ..noOflikes = streamData.noOflikes!
            ..noOfViews = streamData.noOfViews!
            ..articleReportedBy = streamData.articleReportedBy!
            ..socialMediaLink = streamData.socialMediaLink!;

          final box = Boxes.getArticleFromCloud();

          print('nnn key $k');
          box.putAt(k, newArticleData);
        }
      });
    }
  }

  listenForComments() {
    if (widget.docId != null) {
      final clearBox = Boxes.getArticleCommentsFromCloud();
      clearBox.clear();

      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          .doc(widget.docId)
          .collection('Comments')
          .orderBy('TimeStamp')
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) async {
          print('nnnd db ${element.id}');
          CodeArticlesCommentModel model =
              CodeArticlesCommentModel.fromJson(element);

          final data = HiveArticlesComments()
            ..comment = model.comment!
            ..commentName = model.commentName!
            ..commentTime = model.commentTime!
            ..commentUid = model.commentUid!;

          final box = Boxes.getArticleCommentsFromCloud();
          box.put(model.commentTime, data);
        });
      });
    }
  }

  increaseArticleViews() {
    Future.delayed(Duration(seconds: 5), () {
      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          .doc(widget.docId)
          .update({'NoOfViews': FieldValue.increment(1)});
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkUserCubit = BlocProvider.of<CheckuserloginedCubit>(context);
    checkUserCubit.checkLogin();
    return WillPopScope(
      onWillPop: () async {
        print('nnn backButton Working');
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Column(
            children: [
              HomePageHeader(wantSearchBar: false),
              Row(
                children: [
                  BodyRightPane(),
                  ArticleBodyRightPane(
                    data: widget.data,
                    docId: widget.docId,
                  ),
                  BodyRightPane()
                ],
              ),
              HomePageFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
