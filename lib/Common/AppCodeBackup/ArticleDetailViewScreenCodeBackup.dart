import 'dart:async';
import 'package:Journz/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
import 'package:Journz/HomeScreen/Screen/HomeScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/ArticleDetailView/Screen/GalleryImageViewScreen.dart';
import '/Articles/ArticlesBloc/GalleryPhotoCubit/galleryphoto_cubit.dart';
import '/Articles/ArticlesBloc/UploadGalleryImage/uploadgalleryimg_cubit.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/ArticleDetailView/DataModel/CommentModel.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/Articles/ArticlesBloc/ArticlesSubtypeCubit/articlesubtype_cubit.dart';
import '/Articles/ArticlesBloc/SearchTagCubit/SearchTag_cubit.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/Articles/Screens/ArticlesCreation.dart';
import '/Authentication/Screens/VerifyEmail.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Widgets/ReportHelperWidget.dart';
import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class ArticlesDetailViewScreen extends StatefulWidget {
  String documentId;
  String? title;
  bool fromNotification;
  bool fromEdit;
  bool fromReviewOrReject;
  String? checkMobileNumberLinked;

  ArticlesModel? data;
  // String? articleTitle;
  ArticlesDetailViewScreen(
      {Key? key,
      this.data,
      this.checkMobileNumberLinked,
      required this.documentId,
      this.title,
      required this.fromNotification,
      required this.fromEdit,
      required this.fromReviewOrReject

      /* this.articleTitle*/
      })
      : super(key: key);

  @override
  _ArticlesDetailViewScreenState createState() =>
      _ArticlesDetailViewScreenState();
}

class _ArticlesDetailViewScreenState extends State<ArticlesDetailViewScreen> {
  late ArticlesModel model;
  late String title, authorName, subtype;
  String? published;
  var postId;

  TextEditingController commentTextController = TextEditingController();

  var name;

  var noOfComment;
  @override
  void initState() {
    context.read<ArticlesdetailCubit>().getArticleDetail(widget.documentId);
    if (FirebaseAuth.instance.currentUser != null) {
      ArticleDetailViewDB()
          .commentPersonName(FirebaseAuth.instance.currentUser!.uid)
          .then((value) {
        name = value.data()!['Name'];
      });
    } else {
      name = '';
    }
    getCommentNos();
    addViewsForAnArticle();
    getPrefs();
    super.initState();
  }

  var pref;
  getPrefs() async {
    pref = await SharedPreferences.getInstance();
  }

  getCommentNos() async {
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(widget.documentId)
        .get()
        .then((value) async {
      noOfComment = int.parse(await value.get('NoOfComment'));
    });
  }

  addViewsForAnArticle() async {
    await ArticleDetailViewDB()
        .getviewsoFAnArticle(widget.documentId)
        .then((value) async {
      await Future.delayed(Duration(seconds: 30), () async {
        int number = await value.data()!['NoOfViews'];
        ArticleDetailViewDB()
            .addviewsForAnArticle(widget.documentId, number + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('nnn document id ${widget.documentId}');
    final cubit = BlocProvider.of<ArticlelikeCubit>(context);
    cubit.getInitialstate(widget.documentId);

    final shareCubit = BlocProvider.of<DetailviewdynamiclinkCubit>(context);
    final bookmarkCubit = BlocProvider.of<BookmarkCubit>(context);
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      bookmarkCubit.checkBookmarked(
          FirebaseAuth.instance.currentUser!.uid, widget.documentId);
    }

    final commentCubit = BlocProvider.of<CommentStreamCubit>(context);
    commentCubit.getStream(widget.documentId);
    final commentNosCubit = BlocProvider.of<CommentnumbersCubit>(context);

//    final bookmarkCubit = BlocProvider.of<BookmarkCubit>(context);
    if (FirebaseAuth.instance.currentUser != null) {
      bookmarkCubit.checkBookmarked(
          FirebaseAuth.instance.currentUser!.uid, widget.documentId);
    }
    final reportCubit = BlocProvider.of<ArticlereportCubit>(context);
    reportCubit.checkArticleReported(widget.documentId);

    //detailCubit.getArticleDetail(widget.documentId);
    final articleTitleCubit = BlocProvider.of<ArticletitleCubit>(context);
    articleTitleCubit.getTitle(widget.documentId);
    return WillPopScope(
        onWillPop: () async {
          print('nnn back button pressed');
          if (widget.fromNotification) {
            print('nnn b ece');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => SharedprefCubit(pref),
                        child: HomeScreen(curIndex: 0))));
          }
          return Future.value(true);
        },
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('ArticlesCollection')
                .doc(widget.documentId)
                .get(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Scaffold(
                      appBar: AppBar(
                        title:
                            BlocBuilder<ArticletitleCubit, ArticletitleState>(
                          builder: (context, state) {
                            return Text(
                              widget.title ?? state.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        actions: [
                          widget.fromEdit
                              ? IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            GalleryphotoCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            UploadgalleryimgCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            SearchTagCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlesubtypeCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            AddphotoarticleCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            SignupcheckboxCubit()),
                                                  ],
                                                  child: ArticlesCreation(
                                                    fromEdit: true,
                                                    model: widget.data,
                                                  ),
                                                )));
                                  },
                                  icon: Icon(Icons.edit))
                              : Container(),
                          BlocBuilder<BookmarkCubit, BookmarkcubitState>(
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    if (FirebaseAuth
                                            .instance.currentUser?.uid !=
                                        null) {
                                      if (FirebaseAuth.instance.currentUser!
                                          .emailVerified) {
                                        state.isBookmarked
                                            ? bookmarkCubit
                                                .removeBookmarkedArticleInUserCollection(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                widget.documentId,
                                              )
                                            : bookmarkCubit.bookMarkArticleInUserCollection(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                widget.documentId,
                                                title,
                                                authorName);
                                        state.isBookmarked
                                            ? bookmarkCubit
                                                .removeBookmarkArticleInArticleCollection(
                                                    widget.documentId)
                                            : bookmarkCubit
                                                .bookmarkArticleInArticleCollection(
                                                    widget.documentId);
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerifyEmailScreen()));
                                      }
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserNotLoggedInScreen()));
                                    }
                                  },
                                  tooltip: 'Save Article in Your Collection',
                                  icon: state.isBookmarked
                                      ? Icon(Icons.bookmark)
                                      : Icon(Icons.bookmark_border));
                            },
                          ),
                          BlocBuilder<ArticlereportCubit, ArticlereportState>(
                            builder: (context, state) {
                              return BlocBuilder<ThemebasedwidgetCubit,
                                  ThemebasedwidgetState>(
                                builder: (context, tState) {
                                  return IconButton(
                                    onPressed: () {
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        if (FirebaseAuth.instance.currentUser!
                                            .emailVerified) {
                                          state.isReported
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return tState.isLightTheme
                                                        ? ShowAlertNewDarkDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Article Already Reported')
                                                        : ShowAlertNewLightDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Article Already Reported');
                                                  })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ArticlereportCubit(),
                                                            child: Chumma(
                                                                authorname:
                                                                    authorName,
                                                                documentId: widget
                                                                    .documentId,
                                                                subtype:
                                                                    subtype,
                                                                title: title),
                                                          )));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VerifyEmailScreen()));
                                        }
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserNotLoggedInScreen()));
                                      }
                                    },
                                    icon: state.isReported
                                        ? Icon(Icons.report)
                                        : Icon(Icons
                                            .report_gmailerrorred_outlined),
                                    tooltip: 'Report An Article',
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          width: getWidth(context),
                          child: Column(
                            children: [
                              Container(
                                child: BlocBuilder<ArticlesdetailCubit,
                                    ArticlesdetailState>(
                                  builder: (context, state) {
                                    print(
                                        'nnn State ${state.articlesDetailStream}');
                                    return StreamBuilder(
                                      stream: state.articlesDetailStream,
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          model = ArticlesModel.fromJson(
                                              snapshot.data);
                                          published = model.isArticlePublished!;
                                          /*model = ArticlesModel(
                                      articleSubType:
                                          snapshot.data['ArticleSubType'],
                                      articledesc:
                                          snapshot.data['ArticleDescription'],
                                      articletitle: snapshot.data['ArticleTitle'],
                                      authorName: snapshot.data['AuthorName'],
                                      authorUid: snapshot.data['AuthorUID'],
                                      bookMarkedPeoples:
                                          snapshot.data['BookmarkedBy'],
                                      createdTime: snapshot.data['CreatedTime'],
                                      hasImage: snapshot.data['HasImage'],
                                      isArticlePublished:
                                          snapshot.data['IsArticlePublished'],
                                      isArticleReported:
                                          snapshot.data['IsArticleReported'],
                                      noOfComment: snapshot.data['NoOfComment'],
                                      noOfLike: snapshot.data['NoOfLikes'],
                                      peopleLike: snapshot.data['ArticleLike'],
                                      photoUrl: snapshot.data['ArticlePhotoUrl'],
                                      updatedTime: snapshot.data['UpdatedTime']);*/
                                          title = model.articletitle!;
                                          authorName = model.authorName!;
                                          subtype = model.articleSubType!;
                                        }
                                        return snapshot.hasData
                                            ? /*snapshot.data!.docs.length == 0
                                        ? Center(
                                            child: Text(
                                                'Failed To Connect With Server'))
                                        :*/
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    getWidth(context) * 0.03,
                                                    getWidth(context) * 0.03,
                                                    getWidth(context) * 0.03,
                                                    0),
                                                width: getWidth(context),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      model.hasImage == 'Yes'
                                                          ? Container(
                                                              width: getWidth(
                                                                  context),
                                                              height: getWidth(
                                                                      context) *
                                                                  0.8,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                              image:
                                                                                  CachedNetworkImageProvider(
                                                                                model.photoUrl!,
                                                                              ),
                                                                              fit: BoxFit
                                                                                  .fill),
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              25),
                                                                          topRight:
                                                                              Radius.circular(25))),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                          height: getWidth(
                                                                  context) *
                                                              0.05),
                                                      Container(
                                                          child: SelectableText(
                                                              snapshot.data[
                                                                      'ArticleTitle']
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                      SizedBox(
                                                          height: getWidth(
                                                                  context) *
                                                              0.05),
                                                      Container(
                                                          child: SelectableLinkify(
                                                              onOpen: onOpen,
                                                              linkStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  color: Colors
                                                                      .blue),
                                                              text: model
                                                                  .articledesc!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: TextStyle(
                                                                  fontSize: 18))
                                                          /* .text
                                                              .xl
                                                              .justify
                                                              .make()*/
                                                          ),
                                                      SizedBox(
                                                          height: getWidth(
                                                                  context) *
                                                              0.05),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Views : ${model.noOfViews}')
                                                                  .text
                                                                  .bold
                                                                  .make(),
                                                              Text(
                                                                  'Author - ${model.authorName}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          getWidth(context) *
                                                                              0.05,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          )),
                                                      SizedBox(
                                                          height: getWidth(
                                                                  context) *
                                                              0.025),
                                                      model.galleryImages!
                                                                  .length !=
                                                              0
                                                          ? Container(
                                                              width: context
                                                                  .screenWidth,
                                                              height: context
                                                                      .screenWidth *
                                                                  0.4,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  /*   "Gallery"
                                                                      .text
                                                                      .xl
                                                                      .bold
                                                                      .red500
                                                                      .make(),*/
                                                                  GridView.builder(
                                                                      physics: PageScrollPhysics(),
                                                                      shrinkWrap: true,
                                                                      itemCount: 3,
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                                      itemBuilder: (context, index) {
                                                                        return index ==
                                                                                2
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryImageViewScreen(gallery: model.galleryImages!)));
                                                                                },
                                                                                child: Container(
                                                                                  child: Text('See More').text.bold.makeCentered(),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.007),
                                                                                decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(model.galleryImages![index]['GalleryImageUrl']), fit: BoxFit.fill)),
                                                                              );
                                                                      })
                                                                ],
                                                              ),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                          height: getWidth(
                                                                  context) *
                                                              0.025),
                                                      //TODO: implement Comment Here
                                                      /* MultiBlocProvider(
                                                        providers: [
                                                          BlocProvider(
                                                            create: (context) =>
                                                                DetailviewdynamiclinkCubit(),
                                                          ),
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ArticlelikeCubit(),
                                                          ),
                                                          BlocProvider(
                                                              create: (context) =>
                                                                  BookmarkCubit()),
                                                          BlocProvider(
                                                              create: (context) =>
                                                                  CommentnumbersCubit())
                                                        ],
                                                        child:
                                                            BookmarkLikeShareTab(
                                                          model: model,
                                                          documentId:
                                                              widget.documentId,
                                                          title: model
                                                              .articletitle!,
                                                          desc: model
                                                              .articledesc!,
                                                          authorName:
                                                              model.authorName!,
                                                        ),
                                                      ),*/

                                                      model.isArticlePublished! ==
                                                              "Published"
                                                          ? Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          getWidth(context) *
                                                                              0.01),
                                                              width: getWidth(
                                                                      context) *
                                                                  0.99,
                                                              height: getWidth(
                                                                      context) *
                                                                  0.1,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          /*        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                            create: (context) =>
                                                CheckuserloginedCubit()),
                                        BlocProvider(
                                            create: (context) =>
                                                CommentStreamCubit()),
                                      ],
                                      child: ArticleCommentScreen(
                                        documentId: widget.documentId,
                                        name: name,
                                      ),
                                    )));*/
                                                                        },
                                                                        child: Container(
                                                                            width: getWidth(context) * 0.4,
                                                                            height: getWidth(context) * 0.1,
                                                                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.solidCommentDots,
                                                                                color: Colors.black,
                                                                              ),
                                                                              /*          BlocBuilder<CommentStreamCubit, CommentCubitState>(
                  builder: (context, state) {
                    return */
                                                                              BlocBuilder<CommentnumbersCubit, CommentnumbersState>(
                                                                                builder: (context, cState) {
                                                                                  print('nnn no of cState ${cState.noOfComment}');
                                                                                  return Text('${cState.noOfComment} Comments').text.black.makeCentered();
                                                                                },
                                                                              )
                                                                            ]))

                                                                        /*Container(
              width: getWidth(context) * 0.4,
              height: getWidth(context) * 0.1,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(FontAwesomeIcons.solidCommentDots),
                  BlocBuilder<CommentStreamCubit, CommentCubitState>(
                    builder: (context, state) {
                      return Text(
                          '${state.noOfComment == null ? 0 : state.noOfComment} Comments');
                    },
                  )
                ],
              ),
            ),*/
                                                                        ),
                                                                    BlocBuilder<
                                                                        ArticlelikeCubit,
                                                                        ArticlelikeState>(
                                                                      builder:
                                                                          (context,
                                                                              state) {
                                                                        print(
                                                                            'nnn like state ${state.isLiked} ${state.noOfLike}');
                                                                        return Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width:
                                                                              getWidth(context) * 0.2,
                                                                          height:
                                                                              getWidth(context) * 0.1,
                                                                          color:
                                                                              Colors.grey[300],
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    if (FirebaseAuth.instance.currentUser?.uid != null) {
                                                                                      if (FirebaseAuth.instance.currentUser!.emailVerified) {
                                                                                        state.isLiked! ? cubit.disLikeArticle(widget.documentId) : cubit.likedArticle(widget.documentId);
                                                                                      } else {
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmailScreen()));
                                                                                      }
                                                                                    } else {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotLoggedInScreen()));
                                                                                    }
                                                                                  },
                                                                                  icon: state.isLiked!
                                                                                      ? Icon(
                                                                                          Icons.favorite,
                                                                                          color: Colors.black,
                                                                                        )
                                                                                      : Icon(
                                                                                          Icons.favorite_outline,
                                                                                          color: Colors.black,
                                                                                        )),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  state.noOfLike.toString(),
                                                                                ).text.black.makeCentered(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    IconButton(
                                                                        icon: Icon(Icons
                                                                            .share),
                                                                        onPressed:
                                                                            () {
                                                                          /* shareCubit.createDynamicLink(
                                                                              true,
                                                                              model.documentId!,
                                                                              model.articletitle!,
                                                                              '/Articles',
                                                                              model.articledesc!); */
                                                                          Share.share(model
                                                                              .socialMediaLink!
                                                                              .trim());
                                                                        })
                                                                  ]))
                                                          : Container()
                                                    ]))
                                            : Center(
                                                child: Text(
                                                    'Articles Loading...'));
                                      },
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context) * 0.03),
                                width: getWidth(context),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Comments',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: TextField(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context) * 0.03),
                                            height: getWidth(context) * 0.85,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller:
                                                      commentTextController,
                                                  //expands: true,
                                                  minLines: 1, autofocus: true,
                                                  maxLines: 6,
                                                  focusNode: FocusNode(),
                                                  decoration: InputDecoration(
                                                      hintText: 'Comments',
                                                      //prefixIcon: Icon(Icons.comment),
                                                      suffixIcon: BlocBuilder<
                                                          ThemebasedwidgetCubit,
                                                          ThemebasedwidgetState>(
                                                        builder:
                                                            (context, tState) {
                                                          return IconButton(
                                                            onPressed: () {
                                                              if (FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid !=
                                                                  null) {
                                                                if (FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .emailVerified) {
                                                                  if (widget
                                                                          .checkMobileNumberLinked ==
                                                                      "Verified") {
                                                                    CommentModel model = CommentModel(
                                                                        createdTime:
                                                                            FieldValue
                                                                                .serverTimestamp(),
                                                                        userName:
                                                                            name,
                                                                        comment: commentTextController
                                                                            .text
                                                                            .trim(),
                                                                        uid: FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid);
                                                                    if (commentTextController
                                                                        .text
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      ArticleDetailViewDB().postComment(
                                                                          widget
                                                                              .documentId,
                                                                          model
                                                                              .toJson());

                                                                      commentTextController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return tState.isLightTheme
                                                                                ? ShowAlertNewDarkDialogBox(alertType: 'Alert..!', alertMessage: 'Empty Comments Are Not Accepted')
                                                                                : ShowAlertNewLightDialogBox(alertType: 'Alert..!', alertMessage: 'Empty Comments Are Not Accepted');
                                                                          });
                                                                    }
                                                                  } else {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return tState.isLightTheme
                                                                              ? AlertDialog(
                                                                                  title: Text('Alert..!'),
                                                                                  content: Text('Mobile Number Not Verified Please Verify Mobile Number in Profile Section'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text('Close', style: Theme.of(context).textTheme.headline6))
                                                                                  ],
                                                                                )
                                                                              : AlertDialog(
                                                                                  title: Text('Alert..!'),
                                                                                  content: Text('Mobile Number Not Verified Please Verify Mobile Number in Profile Section'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text('Close', style: Theme.of(context).textTheme.headline6))
                                                                                  ],
                                                                                );
                                                                        });
                                                                  }
                                                                } else {
                                                                  commentTextController
                                                                      .clear();
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              VerifyEmailScreen()));
                                                                }
                                                              } else {
                                                                commentTextController
                                                                    .clear();
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                UserNotLoggedInScreen()));
                                                              }
                                                            },
                                                            tooltip:
                                                                'Post Comment',
                                                            icon: Icon(
                                                                Icons.send),
                                                          );
                                                        },
                                                      )),
                                                ),
                                                40.heightBox,
                                                "Swipe Down to Close"
                                                    .text
                                                    .xl
                                                    .makeCentered(),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: 'Post A Comment'),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: context.screenWidth * 0.04,
                                  ),
                                  // width: context.screenWidth,
                                  // height: context.screenHeight,
                                  child: Container(
                                    //constraints:
                                    // BoxConstraints(maxHeight: getWidth(context) * 1.4),
                                    // height: getHeight(context) * 0.85,
                                    child: BlocBuilder<CommentStreamCubit,
                                        CommentCubitState>(
                                      //print('nnn str bloc ${state.}')
                                      builder: (context, state) {
                                        return StreamBuilder(
                                          stream: state.commentStream,
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            print(
                                                'nnn str ${snapshot.hasData}');

                                            return snapshot.hasData
                                                ? snapshot.data.docs.length != 0
                                                    ? ListView.builder(
                                                        physics: PageScrollPhysics(
                                                            parent:
                                                                ScrollPhysics()),
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data.docs.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          CommentModel model =
                                                              CommentModel.fromJson(
                                                                  snapshot.data
                                                                          .docs[
                                                                      index]);
                                                          noOfComment = snapshot
                                                              .data.docs.length;
                                                          print(
                                                              'nnn no of $noOfComment');
                                                          commentNosCubit
                                                              .getCommentNos(
                                                                  noOfComment
                                                                      .toString());
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                BlocBuilder<
                                                                    CheckuserloginedCubit,
                                                                    CheckuserloginedState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    return Container(
                                                                      //constraints: BoxConstraints(
                                                                      //  maxHeight: double.infinity),
                                                                      //  color: Colors.red,
                                                                      width: getWidth(
                                                                          context),
                                                                      padding: EdgeInsets.all(
                                                                          getWidth(context) *
                                                                              0.03),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(model.userName ?? 'Navaneethan Thangaraj', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: getWidth(context) * 0.05)),
                                                                              SizedBox(
                                                                                height: getWidth(context) * 0.015,
                                                                              ),
                                                                              Container(padding: EdgeInsets.only(left: getWidth(context) * 0.03), width: FirebaseAuth.instance.currentUser != null ? getWidth(context) * 0.8 : getWidth(context) * 0.9, child: Text(model.comment ?? 'This Article Is Impressive', textAlign: TextAlign.justify, semanticsLabel: 'true', style: Theme.of(context).textTheme.bodyText2!.copyWith(wordSpacing: 1.5))),
                                                                            ],
                                                                          ),
                                                                          FirebaseAuth.instance.currentUser != null
                                                                              ? model.uid! == FirebaseAuth.instance.currentUser!.uid
                                                                                  ? IconButton(
                                                                                      onPressed: () {
                                                                                        FirebaseFirestore.instance.collection('ArticlesCollection').doc(widget.documentId).collection('Comments').doc(snapshot.data.docs[index].id).delete().then((value) {
                                                                                          FirebaseFirestore.instance.collection('ArticlesCollection').doc(widget.documentId).update({
                                                                                            'NoOfComment': noOfComment == null ? '0' : noOfComment!.toString()
                                                                                          });
                                                                                        });
                                                                                      },
                                                                                      icon: Icon(Icons.delete))
                                                                                  : Container()
                                                                              : Container()
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                Divider(
                                                                  thickness: 3,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child: Text(
                                                            'Be The First One To Comment'),
                                                      )
                                                : Center(
                                                    child: Text(
                                                        'Comment Loading...'));
                                          },
                                        );
                                      },
                                    ),
                                  )

                                  /*MultiBlocProvider(
                          providers: [
                            BlocProvider(
                                create: (context) => CheckuserloginedCubit()),
                            BlocProvider(create: (context) => CommentStreamCubit()),
                          ],
                          child: ArticleCommentScreen(
                            documentId: widget.documentId,
                            //name: name,
                          ),
                        ),*/
                                  ),
                              //SizedBox(height: getWidth(context) * 0.13),
                              //Spacer(),
                              /*FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('ArticlesCollection')
                                      .doc(widget.documentId)
                                      .get(),
                                  builder: (context, snapshot) {
                                    print('nnn pub $published');
                                    return snapshot.hasData
                                        ? !widget.fromReviewOrReject
                                            ? Card(
                                                elevation: 12,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          getWidth(context) *
                                                              0.03),
                                                  height:
                                                      getWidth(context) * 0.2,
                                                  child: TextField(
                                                    controller:
                                                        commentTextController,
                                                    //expands: true,
                                                    minLines: 1,
                                                    maxLines: 6,
                                                    decoration: InputDecoration(
                                                        hintText: 'Comments',
                                                        //prefixIcon: Icon(Icons.comment),
                                                        suffixIcon: IconButton(
                                                          onPressed: () {
                                                            if (FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid !=
                                                                null) {
                                                              if (FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .emailVerified) {
                                                                CommentModel model = CommentModel(
                                                                    createdTime:
                                                                        FieldValue
                                                                            .serverTimestamp(),
                                                                    userName:
                                                                        name,
                                                                    comment:
                                                                        commentTextController
                                                                            .text,
                                                                    uid: FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid);
                                                                ArticleDetailViewDB()
                                                                    .postComment(
                                                                        widget
                                                                            .documentId,
                                                                        model
                                                                            .toJson());
                                                                commentTextController
                                                                    .clear();
                                                              } else {
                                                                commentTextController
                                                                    .clear();
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                VerifyEmailScreen()));
                                                              }
                                                            } else {
                                                              commentTextController
                                                                  .clear();
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              UserNotLoggedInScreen()));
                                                            }
                                                          },
                                                          tooltip:
                                                              'Post Comment',
                                                          icon:
                                                              Icon(Icons.send),
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 0,
                                              )
                                        : Container(height: 0);
                                  })*/
                              120.heightBox,
                            ],
                          ),
                        ),
                      ),
                      /*F  bottomSheet: Card(
                        elevation: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context) * 0.03),
                          height: getWidth(context) * 0.2,
                          child: TextField(
                            controller: commentTextController,
                            //expands: true,
                            minLines: 1,
                            maxLines: 6,
                            decoration: InputDecoration(
                                hintText: 'Comments',
                                //prefixIcon: Icon(Icons.comment),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (FirebaseAuth
                                            .instance.currentUser?.uid !=
                                        null) {
                                      if (FirebaseAuth.instance.currentUser!
                                          .emailVerified) {
                                        CommentModel model = CommentModel(
                                            createdTime:
                                                FieldValue.serverTimestamp(),
                                            userName: name,
                                            comment: commentTextController.text,
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid);
                                        ArticleDetailViewDB().postComment(
                                            widget.documentId, model.toJson());
                                        commentTextController.clear();
                                      } else {
                                        commentTextController.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerifyEmailScreen()));
                                      }
                                    } else {
                                      commentTextController.clear();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserNotLoggedInScreen()));
                                    }
                                  },
                                  tooltip: 'Post Comment',
                                  icon: Icon(Icons.send),
                                )),
                          ),
                        ),
                      ),*/
                    )
                  : Scaffold(
                      body: Center(
                        child: Text('Loading...'),
                      ),
                    );
            }));
  }

  Future<void> onOpen(LinkableElement link) async {
    //if (await canLaunch(link.url)) {
    // print('open link ${link.url}');
    await launch(link.url);
    // } else {
    //throw "Cant open link ${link.url}";
    // }
  }

  @override
  void dispose() {
    ArticleDetailViewDB().putZeroInComment(widget.documentId);
    super.dispose();
  }
}
