import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:journz_web/constants/footer.dart';
import 'package:journz_web/constants/leftpane.dart';
import 'package:journz_web/constants/rightpane.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  //final DocumentSnapshot ds;
  final String id;

  // showCommentDialog(BuildContext context, String id) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           child: Container(
  //               //alignment: Alignment.center,
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //               ),
  //               width: 350,
  //               height: 200,
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     // StreamBuilder(
  //                     //   stream: FirebaseFirestore.instance.collection('ArticlesCollection').doc(id),
  //                     // )
  //                   ],
  //                 ),
  //               )
  //           ),
  //         );
  //       });
  //   // showGeneralDialog(
  //   //     context: context,
  //   //     barrierDismissible: true,
  //   //     barrierLabel:
  //   //         MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //   //     barrierColor: Colors.transparent,
  //   //     transitionDuration: const Duration(milliseconds: 200),
  //   //     pageBuilder: (BuildContext buildContext, Animation animation,
  //   //         Animation secondaryAnimation) {
  //   //       return Scaffold(
  //   //         body: Center(
  //   //           child: InkWell(
  //   //             onTap: () {
  //   //               Navigator.of(context).pop();
  //   //             },
  //   //             child: Container(
  //   //                 alignment: Alignment.center,
  //   //                 decoration: BoxDecoration(
  //   //                     color: Colors.green,
  //   //                     borderRadius: BorderRadius.circular(10)),
  //   //                 width: 350,
  //   //                 height: 200,
  //   //                 child: const Text("Hi")),
  //   //           ),
  //   //         ),
  //   //       );
  //   //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            leadingWidth: 70,
            toolbarHeight: 80,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150)),
            elevation: 20,
            shadowColor: Colors.black26,
            leading: Image.asset(
              "assets/images/logo.png",
              height: 100,
              width: 70,
            ),
            title: Text("Journz",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800)),
            //backgroundColor: Colors.blue[150],
            backgroundColor: Colors.white,
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2))),
                      child: Text("Articles",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                  15.widthBox,
                  InkWell(
                    onTap: () {
                      //showInfodialog(context);
                      showConfirm("Section Coming soon");
                    },
                    child: Container(
                      child: Text("News",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300)),
                    ),
                  )
                ],
              ).pOnly(right: 200),
            ],
          ).p20(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeftPane(),
                  //10.widthBox,
                  Center(
                    child: Container(
                      height: context.screenHeight,
                      width: context.percentWidth * 65,
                      //color: Colors.grey[200],
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              topLeft: Radius.circular(7))),
                      child: SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('ArticlesCollection')
                            .where('DocumentId', isEqualTo: id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(Icons.arrow_back)),
                              10.heightBox,
                              Row(
                                children: [
                                  //const Icon(Icons.arrow_back),
                                  //10.widthBox,
                                  Flexible(
                                    child: Text(
                                      snapshot.data!.docs[0]['ArticleTitle'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              snapshot.data!.docs[0]['ArticlePhotoUrl'] !=
                                      'WithoutImage'
                                  ? Container(
                                      width: context.screenWidth,
                                      height: 400,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data!.docs[0]
                                                      ['ArticlePhotoUrl']))),
                                    )
                                  : Container(),
                              10.heightBox,
                              Text(
                                snapshot.data!.docs[0]['ArticleDescription'],
                                //maxLines: 1,
                                //overflow: TextOverflow.ellipsis,
                                style:
                                    // GoogleFonts.poppins
                                    const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300),
                              ),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Author : ${snapshot.data!.docs[0]['AuthorName']}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "Publish Time : ${formattedDate(snapshot.data!.docs[0]['UpdatedTime'])}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              15.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //-----comment button
                                  InkWell(
                                    onTap: () {
                                      // showCommentDialog(context,
                                      //     snapshot.data!.docs[0]['DocumentId']);
                                      launch(
                                          "https://play.google.com/store/apps/details?id=in.journz.journz");
                                    },
                                    child: Container(
                                      height: 50,
                                      width: context.percentWidth * 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(4, 4),
                                              spreadRadius: 1,
                                              blurRadius: 15,
                                              color: Colors.black26),
                                          BoxShadow(
                                              offset: Offset(-4, -4),
                                              spreadRadius: 1,
                                              blurRadius: 15,
                                              color: Colors.white)
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons
                                                .chat_bubble_text_fill,
                                            size: 15,
                                            color: Colors.black,
                                          ),
                                          15.widthBox,
                                          const Text("comment your views")
                                        ],
                                      ).px16(),
                                    ),
                                  ),
                                  //-----like & share button
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launch(
                                              "https://play.google.com/store/apps/details?id=in.journz.journz");
                                        },
                                        child: Container(
                                          height: 50,
                                          width: context.percentWidth * 6,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(4, 4),
                                                  spreadRadius: 1,
                                                  blurRadius: 15,
                                                  color: Colors.black26),
                                              BoxShadow(
                                                  offset: Offset(-4, -4),
                                                  spreadRadius: 1,
                                                  blurRadius: 15,
                                                  color: Colors.white)
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.heart_fill,
                                                size: 15,
                                                color: Colors.red,
                                              ),
                                              15.widthBox,
                                              Text(snapshot
                                                  .data!.docs[0]['NoOfLike']
                                                  .toString())
                                            ],
                                          ).px16(),
                                        ),
                                      ),
                                      10.widthBox,
                                      //-------share
                                      InkWell(
                                        onTap: () {
                                          launch(
                                              "https://play.google.com/store/apps/details?id=in.journz.journz");
                                        },
                                        child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            width: context.percentWidth * 4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(4, 4),
                                                    spreadRadius: 1,
                                                    blurRadius: 15,
                                                    color: Colors.black26),
                                                BoxShadow(
                                                    offset: Offset(-4, -4),
                                                    spreadRadius: 1,
                                                    blurRadius: 15,
                                                    color: Colors.white)
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              10.heightBox
                            ],
                          ).p32();
                        },
                      )
                          //ArticleDetails(ds: ds).p32(),
                          ),
                    ),
                  ),
                  const RightPane()
                ],
              ),
              const Footer()
            ],
          ),
        ));
  }
}

String formattedDate(timeStamp) {
  var dateFromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat.yMMMd().format(dateFromTimeStamp);
}
