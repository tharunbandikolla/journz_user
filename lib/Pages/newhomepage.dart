import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journz_web/Pages/detailspage.dart';
import 'package:journz_web/constants/footer.dart';
import 'package:journz_web/constants/leftpane.dart';
import 'package:journz_web/constants/rightpane.dart';
//import 'package:journz_web/components/sidemenu.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const homescreen = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var _item;
  late int currentPage;
  //late bool selected = true;

  @override
  void initState() {
    super.initState();
    _item = null;
    currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    //int currentPage = 0;
    //String category = "";

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
            ).pOnly(right: 200),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //const Header(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeftPane(),
                  Center(
                    child: Container(
                      //alignment: Alignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            subType(),
                            10.heightBox,
                            Articles(item: _item).p16()
                          ],
                        ),
                      ),
                    ),
                  ),
                  const RightPane(),
                ],
              ),
              10.heightBox,
              const Footer()
            ],
          ),
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> subType() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ArticleSubtype')
          .orderBy('Index')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return 15.widthBox;
            },
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  // category = ds['SubType'];
                  // print(category);
                  setState(() {
                    _item = ds;
                    currentPage = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    ds['PhotoPath'],
                                  )),
                              shape: BoxShape.circle,
                              // border:
                              // Border.all(
                              //     color: Colors.transparent, width: 3),
                              //borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                        ),
                      ),
                    ),
                    5.heightBox,
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        child: Text(
                          ds['SubType'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ).p32();
      },
    );
  }
}

class Articles extends StatelessWidget {
  const Articles({
    Key? key,
    required item,
  })  : _item = item,
        super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final _item;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _item == null || _item['SubType'] == 'All'
          ? FirebaseFirestore.instance
              .collection('ArticlesCollection')
              //.orderBy('Index')
              .snapshots()
          : FirebaseFirestore.instance
              .collection('ArticlesCollection')
              .where('ArticleSubType', isEqualTo: _item['SubType'])
              //.orderBy('Index')
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Loading Articles"));
        }
        if (snapshot.data!.docs.isEmpty) {
          Center(
            child: "Amazing Articles on your way".text.xl.bold.make(),
          );
        }
        return SizedBox(
          height: 550,
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //physics: const AlwaysScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 9,
            itemCount: snapshot.data!.docs.length,
            staggeredTileBuilder: (index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return StaggeredTile.count(
                  3, ds['ArticlePhotoUrl'] == 'WithoutImage' ? 1.5 : 3);
            },
            // staggeredTileBuilder: (index) =>
            //     StaggeredTile.count(3, index.isEven ? 2 : 1),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(ds: ds)));
                  },
                  child: VxBox(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ds['ArticlePhotoUrl'] != 'WithoutImage'
                          ? Container(
                              width: context.screenWidth,
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(ds['ArticlePhotoUrl']))),
                            )
                          : Container(),
                      10.heightBox,
                      Flexible(
                        child: Text(
                          ds['ArticleTitle'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ).px12(),
                      ),
                      5.heightBox,
                      Flexible(
                        child: Text(
                          ds['ArticleDescription'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              textStyle: context.captionStyle,
                              fontWeight: FontWeight.normal),
                        ).px12(),
                      ),
                      15.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Flexible(
                          //   child: Text(
                          //     "Author : ${ds['AuthorName']}",
                          //     overflow: TextOverflow.ellipsis,
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 15, fontWeight: FontWeight.w600),
                          //   ).px12(),
                          // ),
                          10.widthBox,
                          Container(
                            height: 30,
                            width: 45,
                            alignment: Alignment.center,
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
                                  CupertinoIcons.heart_fill,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                5.widthBox,
                                Text(ds['NoOfLikes'])
                              ],
                            ).p4(),
                          ),
                          10.widthBox,
                          Container(
                            height: 30,
                            width: 45,
                            alignment: Alignment.center,
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
                                5.widthBox,
                                Text(ds['NoOfComment'])
                              ],
                            ).p4(),
                          ),
                          10.widthBox,
                          // share
                          Container(
                            height: 30,
                            width: 45,
                            alignment: Alignment.center,
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
                            child: const Icon(
                              Icons.share,
                              size: 15,
                              color: Colors.black,
                            ),
                          ).p4(),
                        ],
                      ).p8(),
                      // 10.heightBox
                    ],
                  ))
                      .square(
                          ds['ArticlePhotoUrl'] == 'WithoutImage' ? 50 : 120)
                      .neumorphic(
                          curve: VxCurve.emboss,
                          elevation: 31,
                          color: Colors.grey[200])
                      .make(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
