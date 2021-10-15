import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/DataModel/CommentModel.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';

import '/Common/Constant/Constants.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCommentScreen extends StatefulWidget {
  String? name, documentId;
  ArticleCommentScreen(
      {Key? key, required this.documentId}) //, required this.name})
      : super(key: key);

  @override
  _ArticleCommentScreenState createState() => _ArticleCommentScreenState();
}

class _ArticleCommentScreenState extends State<ArticleCommentScreen> {
  TextEditingController commentTextController = TextEditingController();
  int? noOfComment;

  @override
  void initState() {
    getCommentNos();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final commentCubit = BlocProvider.of<CommentStreamCubit>(context);
    commentCubit.getStream(widget.documentId!);
    final checkUserLoggedin = BlocProvider.of<CheckuserloginedCubit>(context);
    checkUserLoggedin.checkLogin();
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Container(
        //constraints:
        // BoxConstraints(maxHeight: getWidth(context) * 1.4),
        height: getHeight(context) * 0.78,
        child: BlocBuilder<CommentStreamCubit, CommentCubitState>(
          //print('nnn str bloc ${state.}')
          builder: (context, state) {
            return StreamBuilder(
              stream: state.commentStream,
              builder: (context, AsyncSnapshot snapshot) {
                print('nnn str ${snapshot.hasData}');

                return snapshot.hasData
                    ? snapshot.data.docs.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              CommentModel model = CommentModel.fromJson(
                                  snapshot.data.docs[index]);
                              noOfComment = snapshot.data.docs.length;
                              print('nnn no of $noOfComment');
                              return Container(
                                child: Column(
                                  children: [
                                    BlocBuilder<CheckuserloginedCubit,
                                        CheckuserloginedState>(
                                      builder: (context, state) {
                                        return Container(
                                          //constraints: BoxConstraints(
                                          //  maxHeight: double.infinity),
                                          width: getWidth(context),
                                          padding: EdgeInsets.all(
                                              getWidth(context) * 0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      model.userName ?? 'check',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: getWidth(
                                                                      context) *
                                                                  0.05)),
                                                  SizedBox(
                                                    height: getWidth(context) *
                                                        0.015,
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: getWidth(
                                                                  context) *
                                                              0.03),
                                                      width: getWidth(context) *
                                                          0.8,
                                                      child: Text(
                                                          model.comment ??
                                                              'check',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          semanticsLabel:
                                                              'true',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  wordSpacing:
                                                                      1.5))),
                                                ],
                                              ),
                                              model.uid! ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                  ? IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ArticlesCollection')
                                                            .doc(widget
                                                                .documentId)
                                                            .collection(
                                                                'Comments')
                                                            .doc(snapshot.data
                                                                .docs[index].id)
                                                            .delete()
                                                            .then((value) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'ArticlesCollection')
                                                              .doc(widget
                                                                  .documentId)
                                                              .update({
                                                            'NoOfComment':
                                                                noOfComment ==
                                                                        null
                                                                    ? '0'
                                                                    : noOfComment!
                                                                        .toString()
                                                          });
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete))
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
                            child: Text('Be The First One To Comment'),
                          )
                    : Center(child: Text('Comment Loading...'));
              },
            );
          },
        ),
      ),
/*      bottomSheet: Card(
        elevation: 12,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.03),
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
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (FirebaseAuth.instance.currentUser!.emailVerified) {
                        CommentModel model = CommentModel(
                            userName: widget.name,
                            comment: commentTextController.text,
                            uid: FirebaseAuth.instance.currentUser!.uid);
                        ArticleDetailViewDB()
                            .postComment(widget.documentId, model.toJson());
                        commentTextController.clear();
                        print('nnn no of $noOfComment');
                        FirebaseFirestore.instance
                            .collection('ArticlesCollection')
                            .doc(widget.documentId)
                            .update(
                                {'NoOfComment': (noOfComment! + 1).toString()});
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyEmailScreen()));
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserNotLoggedInScreen()));
                    }
                  },
                  tooltip: 'Post Comment',
                  icon: Icon(Icons.send),
                )),
          ),
        ),
      ),*/
    );
  }

  @override
  void dispose() {
    ArticleDetailViewDB().putZeroInComment(widget.documentId!);
    super.dispose();
  }
}
