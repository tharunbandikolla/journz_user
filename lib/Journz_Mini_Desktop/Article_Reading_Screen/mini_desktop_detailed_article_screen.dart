import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Journz_Tab/tab_home_footer.dart';

import '../../Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '../../Journz_Mobile/HomePage/mobile_home_page_footer.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';

import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'mini_desktop_article_body_right_pane.dart';

class MiniDesktopDetailedArticleScreen extends StatefulWidget {
  final HiveArticleData? data;
  final docId;
  const MiniDesktopDetailedArticleScreen({Key? key, this.data, this.docId})
      : super(key: key);

  @override
  _MiniDesktopDetailedArticleScreenState createState() =>
      _MiniDesktopDetailedArticleScreenState();
}

class _MiniDesktopDetailedArticleScreenState
    extends State<MiniDesktopDetailedArticleScreen> {
  CodeArticleData streamData = CodeArticleData();
  @override
  void didChangeDependencies() {
    checkConnection();
    super.didChangeDependencies();
  }

  checkConnection() async {
    // ConnectivityResult event = await Connectivity().checkConnectivity();
    //if (event != ConnectivityResult.none) {
    listenArticlesData();
    increaseArticleViews();
    // listenForComments();
    //}
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

          box.putAt(k, newArticleData);
        }
      });
    }
  }

  increaseArticleViews() {
    FirebaseFirestore.instance
        .collection('NewArticleCollection')
        .doc(widget.docId)
        .update({'NoOfViews': FieldValue.increment(1)});
  }

  @override
  Widget build(BuildContext context) {
    final checkUserCubit = BlocProvider.of<CheckuserloginedCubit>(context);
    checkUserCubit.checkLogin();
    return WillPopScope(
      onWillPop: () async {
        print("navi poped to root");
        context.vxNav.popToRoot();
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            //height: context.screenHeight,
            width: context.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomePageHeader(wantSearchBar: false, fromMobile: false),
                SizedBox(height: context.screenWidth * 0.01),
                MiniDesktopArticleBodyRightPane(
                  data: widget.data,
                  docId: widget.docId,
                ),
                HomePageFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
