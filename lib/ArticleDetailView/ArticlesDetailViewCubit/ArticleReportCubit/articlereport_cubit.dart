import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';

part 'articlereport_state.dart';

class ArticlereportCubit extends Cubit<ArticlereportState> {
  ArticlereportCubit() : super(ArticlereportState(isReported: false));

  checkArticleReported(String docId) {
    bool isReported = false;
    List<dynamic>? reportList;
    List<String>? reportId;
    ArticleDetailViewDB().checkIsArticleReported(docId).then((value) async {
      // print(
      //   'nnn n list ${value.data()!['ArticleReportedBy'][0]['ReporterId']}');
      //if (value.data()!['ArticleReportedBy'] != null) {
      reportList = await value.data()?['ArticleReportedBy'];
      // }
    });
    Future.delayed(Duration(milliseconds: 600), () {
      List<String> v = [];
      if (reportList != null) {
        for (Map<String, dynamic> i in reportList!) {
          print('nnn n uid ${i['ReporterId']}');
          v.add(i['ReporterId']);
          print('nnn n r v $v');
        }
        reportId = v;
      }
    });
    Future.delayed(Duration(milliseconds: 800), () {
      print('nnn n reid $reportId');
      if (FirebaseAuth.instance.currentUser != null) {
        if (reportId != null) {
          if (reportId!.contains(FirebaseAuth.instance.currentUser!.uid)) {
            print('nnn n true');
            isReported = true;
          } else {
            print('nnn n false');
            isReported = false;
          }
        } else {
          isReported = false;
        }
      }
      emit(state.copyWith(reportedBool: isReported));
    });
  }

  reportArticle(String docid, String reason, String title, String authorName,
      String subtype) {
    List<dynamic> data = [];
    ArticleDetailViewDB().checkIsArticleReported(docid).then((value) async {
      data = await value.data()!['ArticleReportedBy'];
    });
    Future.delayed(Duration(milliseconds: 600), () {
      data.add({
        'ReporterId': FirebaseAuth.instance.currentUser!.uid,
        'ReportReason': reason
      });
    });
    Future.delayed(Duration(milliseconds: 800), () {
      ArticleDetailViewDB().updateReportDetailsInArticle(docid, reason, data);
      ArticleDetailViewDB()
          .reportArticleInDB(docid, title, authorName, subtype);
    });
  }
}
