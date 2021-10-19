import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:journz_web/constants/footer.dart';
import 'package:journz_web/constants/leftpane.dart';
import 'package:journz_web/constants/rightpane.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.ds,
  }) : super(key: key);

  static const detailscreen = "/";

  final DocumentSnapshot ds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Image.asset(
            "assets/images/logo.png",
            // height: 50,
            // width: 50,
          ),
          title: Text("Journz",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
          backgroundColor: Colors.blue[150],
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2))),
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
            ).pOnly(right: 2),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeftPane(),
                  Center(
                    child: Container(
                      height: context.screenHeight,
                      width: context.percentWidth * 70,
                      //color: Colors.grey[200],
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(Icons.arrow_back)),
                                20.widthBox,
                                Text(
                                  ds['ArticleTitle'],
                                  //maxLines: 1,
                                  //overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ds['ArticlePhotoUrl'] != 'WithoutImage'
                                ? Container(
                                    width: context.screenWidth,
                                    height: 400,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                ds['ArticlePhotoUrl']))),
                                  )
                                : Container(),
                            10.heightBox,
                            Text(
                              ds['ArticleDescription'],
                              //maxLines: 1,
                              //overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 23, fontWeight: FontWeight.w500),
                            ),
                            10.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Author : ${ds['AuthorName']}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "Publish Time : ${formattedDate(ds['UpdatedTime'])}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            15.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //-----comment button
                                InkWell(
                                  onTap: () {
                                    launch(
                                        "https://play.google.com/store/apps/details?id=in.journz.journz");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: context.percentWidth * 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.grey[200],
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
                                          CupertinoIcons.chat_bubble_text_fill,
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
                                          color: Colors.grey[200],
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
                                            Text(ds['NoOfLikes'])
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
                                            color: Colors.grey[200],
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
                        ).p32(),
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
