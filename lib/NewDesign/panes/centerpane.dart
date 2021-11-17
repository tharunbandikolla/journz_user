import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:universal_html/js.dart';
import 'package:velocity_x/velocity_x.dart';

class CenterPane extends StatefulWidget {
  const CenterPane({Key? key}) : super(key: key);

  @override
  State<CenterPane> createState() => _CenterPaneState();
}

class _CenterPaneState extends State<CenterPane> {
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
    int all = 0;
    return Material(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightBox,
            "Latest Articles".text.black.bold.xl2.make(),
            25.heightBox,
            LatestArticle(),
            20.heightBox,
            subType(all),
            20.heightBox,
            Articles(item: _item),
            20.heightBox,
            // Container(
            //   height: 200,
            //   color: Colors.black,
            // )
          ],
        ).p12(),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> subType(int all) {
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
              return context.isMobile ? 8.widthBox : 15.widthBox;
            },
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return index == all
                  ? InkWell(
                      onTap: () {
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

class LatestArticle extends StatelessWidget {
  const LatestArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ArticlesCollection')
          //.where('IsArticlePublished', isEqualTo: 'Published')
          .where('ArticlePhotoUrl', isNotEqualTo: 'WithoutImage')
          //.orderBy('UpdatedTime')
          //.limit(1)
          //.orderBy('Index')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Loading Articles"));
        }
        return Container(
          height: 300,
          width: context.screenWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: context.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            snapshot.data!.docs[0]['ArticlePhotoUrl']))),
              ).p8(),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.eye,
                        color: Colors.grey[350],
                        size: 15,
                      ),
                      5.widthBox,
                      Text(
                        snapshot.data!.docs[0]['NoOfViews'].toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  20.widthBox,
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.grey[350],
                        size: 15,
                      ),
                      5.widthBox,
                      Text(
                        snapshot.data!.docs[0]['NoOfComments'].toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  20.widthBox,
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.heart,
                        color: Colors.grey[350],
                        size: 15,
                      ),
                      5.widthBox,
                      Text(
                        snapshot.data!.docs[0]['NoOfLike'].toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  20.widthBox,
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.grey[350],
                        size: 15,
                      ),
                    ],
                  )
                ],
              ).px32(),
              5.heightBox,
              Container(
                height: 30,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  snapshot.data!.docs[0]['ArticleSubType'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ).px16(),
              10.heightBox,
              Flexible(
                child: Text(
                  snapshot.data!.docs[0]['ArticleTitle'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ).px16(),
              ),
            ],
          ),
        );
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
        return context.isMobile
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (BuildContext context, int index) {
                  return 25.heightBox;
                },
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Container(
                    height: 200,
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F8F9),
                      borderRadius: BorderRadius.circular(20),
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
                            color: Color(0xFFF7F8F9))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.heightBox,
                        Flexible(
                          child: Text(
                            ds['ArticleTitle'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ).px16(),
                        ),
                        10.heightBox,
                        Flexible(
                          child: Text(
                            ds['ArticleDescription'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                textStyle: context.captionStyle,
                                fontWeight: FontWeight.normal),
                          ).px16(),
                        ),
                        25.heightBox,
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
                      ],
                    ),
                  );
                },
              )
            : StaggeredGridView.countBuilder(
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
                      3, ds['ArticlePhotoUrl'] == 'WithoutImage' ? 1.5 : 3.0);
                },
                // staggeredTileBuilder: (index) =>
                //     StaggeredTile.count(3, index.isEven ? 2 : 1),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      // context.vxNav.push(
                      //   Uri(
                      //       // path: MyRoutes.detailRoute,
                      //       // queryParameters: {"type": "", "id": ds.id}
                      //       path: MyRoutes.detailnewRoute,
                      //       queryParameters: {"type": "/Articles", "id": ds.id}),
                      // );
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
                                        image: NetworkImage(
                                            ds['ArticlePhotoUrl']))),
                              ).p12()
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
                        .square(
                            ds['ArticlePhotoUrl'] == 'WithoutImage' ? 40 : 100)
                        .withDecoration(
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            // boxShadow: const [
                            //   BoxShadow(
                            //       offset: Offset(4, 4),
                            //       spreadRadius: 1,
                            //       blurRadius: 15,
                            //       color: Colors.black26),
                            //   BoxShadow(
                            //       offset: Offset(-4, -4),
                            //       spreadRadius: 1,
                            //       blurRadius: 15,
                            //       color: Colors.white)
                            // ],
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
