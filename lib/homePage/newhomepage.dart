// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:journz_web/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
//import 'package:journz_web/Pages/detailspage.dart';
import 'package:journz_web/constants/footer.dart';
import 'package:journz_web/constants/leftpane.dart';
import 'package:journz_web/constants/rightpane.dart';
// import 'package:journz_web/homePage/Bloc/DrawerNameCubit/drawername_cubit.dart';
// import 'package:journz_web/homePage/Helper/FavArticleSharedPreferences.dart';
import 'package:journz_web/utils/routes.dart';
// import 'package:provider/src/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//import 'package:journz_web/components/sidemenu.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
              //const Header(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeftPane(),
                  Center(
                    child: Container(
                      //alignment: Alignment.center,
                      height: context.screenHeight,
                      width: context.percentWidth * 65,
                      //color: Colors.white,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              topLeft: Radius.circular(7))),
                      child: SingleChildScrollView(
                        //physics: const NeverScrollableScrollPhysics(),
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
              5.heightBox,
              const Footer()
            ],
          ),
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> subType() {
    int all = 0;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ArticleSubtype')
          //.orderBy('Index')
          .where('NoOfArticles', isGreaterThan: 0)
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
              return index == all
                  ? InkWell(
                      onTap: () {
                        // category = ds['SubType'];
                        // print(category);
                        setState(() {
                          _item = all;
                          //print(_item);
                          //currentPage = index;
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
                                      image: CachedNetworkImageProvider(
                                          'https://picsum.photos/200'),
                                    ),
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
                                "All",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
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
      stream: _item == 0 || _item == null
          ? FirebaseFirestore.instance
              .collection('ArticlesCollection')
              .where('IsArticlePublished', isEqualTo: 'Published')
              //.orderBy('Index')
              .snapshots()
          : FirebaseFirestore.instance
              .collection('ArticlesCollection')
              .where('ArticleSubType', isEqualTo: _item['SubType'])
              .where('IsArticlePublished', isEqualTo: 'Published')
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
        return StaggeredGridView.countBuilder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          //physics: const AlwaysScrollableScrollPhysics(),
          mainAxisSpacing: 9,
          crossAxisSpacing: 9,
          crossAxisCount: 6,
          itemCount: snapshot.data!.docs.length,
          staggeredTileBuilder: (index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return StaggeredTile.count(
                3, ds['ArticlePhotoUrl'] == 'WithoutImage' ? 1.1 : 2.5);
          },
          // staggeredTileBuilder: (index) =>
          //     StaggeredTile.count(3, index.isEven ? 2 : 1),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return InkWell(
              onTap: () {
                context.vxNav.push(
                  Uri(
                      // path: MyRoutes.detailRoute,
                      // queryParameters: {"type": "", "id": ds.id}
                      path: MyRoutes.detailnewRoute,
                      queryParameters: {"type": "/Articles", "id": ds.id}),
                );
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DetailsPage(ds: ds)));
              },
              child: VxBox(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ds['ArticlePhotoUrl'] != 'WithoutImage'
                      ? Container(
                          width: context.screenWidth,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(ds['ArticlePhotoUrl']))),
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
                    ).px16(),
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
                    ).px16(),
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
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(4, 4),
                                spreadRadius: 1,
                                blurRadius: 10,
                                color: Colors.black26),
                            BoxShadow(
                                offset: Offset(-4, -4),
                                spreadRadius: 1,
                                blurRadius: 10,
                                color: Colors.white)
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.heart_fill,
                              size: 15,
                              color: Colors.black,
                            ),
                            5.widthBox,
                            Text(ds['NoOfLike'].toString())
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
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(4, 4),
                                spreadRadius: 1,
                                blurRadius: 10,
                                color: Colors.black26),
                            BoxShadow(
                                offset: Offset(-4, -4),
                                spreadRadius: 1,
                                blurRadius: 10,
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
                            Text(ds['NoOfComments'].toString())
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
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(4, 4),
                                spreadRadius: 1,
                                blurRadius: 10,
                                color: Colors.black26),
                            BoxShadow(
                                offset: Offset(-4, -4),
                                spreadRadius: 1,
                                blurRadius: 10,
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
                  .square(ds['ArticlePhotoUrl'] == 'WithoutImage' ? 30 : 90)
                  .withDecoration(
                    BoxDecoration(
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
                  )
                  // .neumorphic(
                  //     curve: VxCurve.emboss,
                  //     elevation: 31,
                  //     color: Colors.white)
                  .make(),
            );
          },
        );
      },
    );
  }
}
