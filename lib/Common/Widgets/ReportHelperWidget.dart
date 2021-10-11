import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chumma extends StatefulWidget {
  String documentId, title, authorname, subtype;
  Chumma(
      {Key? key,
      required this.authorname,
      required this.documentId,
      required this.subtype,
      required this.title})
      : super(key: key);

  @override
  _ChummaState createState() => _ChummaState();
}

class _ChummaState extends State<Chumma> {
  @override
  Widget build(BuildContext context) {
    final reportCubit = BlocProvider.of<ArticlereportCubit>(context);
    Future.delayed(Duration(seconds: 0), () {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                AlertDialog(
                    title: Text('Report Post..!'),
                    content: Text(
                        'Why are you reporting this ?\nSelect one option below'),
                    actions: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report1,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report2,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report3,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report4,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report5,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                            reportButtonFunction(
                                context,
                                reportCubit,
                                report6,
                                widget.documentId,
                                widget.title,
                                widget.authorname,
                                widget.subtype),
                          ],
                        ),
                      )
                    ]),
                Positioned(
                  top: 145,
                  right: 30,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('X',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.bold))),
                ),
              ],
            );
          });
    });
    return WillPopScope(
      onWillPop: () {
        print('backbutton');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
          BlocProvider(create: (context) => ArticlelikeCubit()),
          BlocProvider(create: (context) => BookmarkCubit()),
          BlocProvider(create: (context) => ArticlesdetailCubit()),
          BlocProvider(create: (context) => ArticlelikeCubit()),
          BlocProvider(create: (context) => CheckuserloginedCubit()),
          BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
          BlocProvider(create: (context) => CommentStreamCubit()),
          BlocProvider(create: (context) => ArticletitleCubit()),
          BlocProvider(create: (context) => CommentnumbersCubit()),
          BlocProvider(create: (context) => ArticlereportCubit()),
          BlocProvider(create: (context) => BookmarkCubit())
        ],
        child: ArticlesDetailViewScreen(
          title: null,
          fromReviewOrReject: false,
          documentId: widget.documentId,
          fromNotification: false,
          fromEdit: false,
        ),
      ),
    );
  }
}

reportButtonFunction(
    BuildContext context,
    ArticlereportCubit cubit,
    String report,
    String documentId,
    String title,
    String authorname,
    String subtype) {
  return InkWell(
    onTap: () {
      cubit.reportArticle(documentId, report, title, authorname, subtype);
      Navigator.pop(context);
      Navigator.of(context).pop();
    },
    child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.13,
        child: Text(report, style: Theme.of(context).textTheme.bodyText1)),
  );
}

/*  reportButtonFunction(BuildContext context, String report) {
    return InkWell(
      onTap: () {
        if (peoplesReported.contains(FirebaseAuth.instance.currentUser.uid)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Article content Already Reported'),
          ));
          Navigator.of(context).pop();
          print('hii contains');
        } else {
          if (reported != 'true') {
            peoplesReported1 = peoplesReported;
            peoplesReported1.add(FirebaseAuth.instance.currentUser.uid);
            reportType1 = reportType;
            reportType1.add(report);
            FirebaseFirestore.instance
                .collection('ArticlesContentReport')
                .doc(widget.postId)
                .set({
              'ReportType': reportType1,
              'ReportedArticle': widget.postId,
              'NoOfUsersReported': '1',
              'PeoplesReported': peoplesReported1,
              'ReportedArticleTitle': title,
              'ReportedArticleAuthor': authorName,
              'Reported': 'true',
              'CreatedAt': DateTime.now().toString(),
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Article Content Reported'),
            ));
            print('hii notcontains');
          } else {
            peoplesReported1 = peoplesReported;
            peoplesReported1.add(FirebaseAuth.instance.currentUser.uid);
            reportType1 = reportType;
            reportType1.add(report);
            noOfUsersReported1 = int.parse(noOfUsersReported);
            FirebaseFirestore.instance
                .collection('ArticlesContentReport')
                .doc(widget.postId)
                .update({
              'ReportType': reportType1,
              'PeoplesReported': peoplesReported1,
              'NoOfUsersReported': (noOfUsersReported1 + 1).toString(),
              'ReportedArticleTitle': title,
              'ReportedArticleAuthor': authorName,
              'CreatedAt': DateTime.now().toString(),
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Article Content Reported'),
            ));
          }
        }
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.13,
          child: Text(report, style: Theme.of(context).textTheme.bodyText1)),
    );
  }*/

/*import 'package:fluenzo/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import 'package:fluenzo/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

reportPostContentDialog(BuildContext context, String documentId, String title,
    String authorname, String subtype) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        final reportCubit = BlocProvider.of<ArticlereportCubit>(context);
        return Stack(
          children: [
            AlertDialog(
                title: Text('Report Post..!'),
                content: Text(
                    'Why are you reporting this ?\nSelect one option below'),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reportButtonFunction(context, reportCubit, report1,
                            documentId, title, authorname, subtype),
                        reportButtonFunction(context, reportCubit, report2,
                            documentId, title, authorname, subtype),
                        reportButtonFunction(context, reportCubit, report3,
                            documentId, title, authorname, subtype),
                        reportButtonFunction(context, reportCubit, report4,
                            documentId, title, authorname, subtype),
                        reportButtonFunction(context, reportCubit, report5,
                            documentId, title, authorname, subtype),
                        reportButtonFunction(context, reportCubit, report6,
                            documentId, title, authorname, subtype),
                      ],
                    ),
                  )
                ]),
            Positioned(
              top: 145,
              right: 30,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('X',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold))),
            ),
          ],
        );
      });
}

reportButtonFunction(
    BuildContext context,
    ArticlereportCubit cubit,
    String report,
    String documentId,
    String title,
    String authorname,
    String subtype) {
  return InkWell(
    onTap: () {
      cubit.reportArticle(documentId, report, title, authorname, subtype);
      Navigator.pop(context);
    },
    child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.13,
        child: Text(report, style: Theme.of(context).textTheme.bodyText1)),
  );
}

/*  reportButtonFunction(BuildContext context, String report) {
    return InkWell(
      onTap: () {
        if (peoplesReported.contains(FirebaseAuth.instance.currentUser.uid)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Article content Already Reported'),
          ));
          Navigator.of(context).pop();
          print('hii contains');
        } else {
          if (reported != 'true') {
            peoplesReported1 = peoplesReported;
            peoplesReported1.add(FirebaseAuth.instance.currentUser.uid);
            reportType1 = reportType;
            reportType1.add(report);
            FirebaseFirestore.instance
                .collection('ArticlesContentReport')
                .doc(widget.postId)
                .set({
              'ReportType': reportType1,
              'ReportedArticle': widget.postId,
              'NoOfUsersReported': '1',
              'PeoplesReported': peoplesReported1,
              'ReportedArticleTitle': title,
              'ReportedArticleAuthor': authorName,
              'Reported': 'true',
              'CreatedAt': DateTime.now().toString(),
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Article Content Reported'),
            ));
            print('hii notcontains');
          } else {
            peoplesReported1 = peoplesReported;
            peoplesReported1.add(FirebaseAuth.instance.currentUser.uid);
            reportType1 = reportType;
            reportType1.add(report);
            noOfUsersReported1 = int.parse(noOfUsersReported);
            FirebaseFirestore.instance
                .collection('ArticlesContentReport')
                .doc(widget.postId)
                .update({
              'ReportType': reportType1,
              'PeoplesReported': peoplesReported1,
              'NoOfUsersReported': (noOfUsersReported1 + 1).toString(),
              'ReportedArticleTitle': title,
              'ReportedArticleAuthor': authorName,
              'CreatedAt': DateTime.now().toString(),
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Article Content Reported'),
            ));
          }
        }
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.13,
          child: Text(report, style: Theme.of(context).textTheme.bodyText1)),
    );
  }*/
*/
