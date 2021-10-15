/*import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Common/Helper/TestSliver/testsliver_cubit.dart';
import '/Common/Widgets/AricleCard.dart';
import '/HomeScreen/Bloc/ArticleCubit/article_cubit.dart';
import '/SearchArticles/Cubit/cubit/searchcubit_cubit.dart';
import '/SearchArticles/Screen/SearchArticlesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class SliverHomeScreen extends StatefulWidget {
  const SliverHomeScreen({Key? key}) : super(key: key);

  @override
  _SliverHomeScreenState createState() => _SliverHomeScreenState();
}

class _SliverHomeScreenState extends State<SliverHomeScreen>
    with TickerProviderStateMixin {
  //TabData data1 = TabData();
  TabController? _controller;
  List<TabData> list = [];
  /* [
    TabData(
        photo:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUom-5bd5IcbjgQznSnGnqso-ULGqX2IbgA&usqp=CAU',
        tab: Tab(
          text: 'Tech',
        )),
    TabData(
        photo:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrqXwRHmWjhrskjYs3P7088ojsd9-gRkwng&usqp=CAU',
        tab: Tab(
          text: 'Social Issue',
        )),
    TabData(
        tab: Tab(
          text: 'Business',
        ),
        photo:
            'https://thumbs.dreamstime.com/b/business-problem-solution-concept-mechanism-teamwork-team-sitting-around-white-table-cogs-130083888.jpg'),
    TabData(
        tab: Tab(text: 'Sports'),
        photo:
            'https://cdn.britannica.com/84/139484-050-D91679CC/Michael-Ballack-Germany-Italy-Cristian-Zaccardo-March-1-2006.jpg')
  ];*/

  getListData() {
    print('nnn l hii');
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        list.add(TabData(
            photo: await element.data()['PhotoPath'],
            tab: Tab(
              icon: Image.network(await element.data()['PhotoPath'])
                  .box
                  .square(35)
                  .make(),
              text: await element.data()['SubType'],
            )));
        print('nnnn list $list');
      });
    });
  }

  ScrollController _scrollBottomBarController = new ScrollController();
  @override
  void initState() {
    getListData();
    super.initState();

    //_controller!.addListener(() {
    //context.read<TestsliverCubit>().setImagePath(_controller!.index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final testSliver = BlocProvider.of<TestsliverCubit>(context);
    print('nnn builder build');
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3))
            .then((value) => Future.value(true)),
        builder: (context, snapshot) {
          _controller = TabController(length: list.length, vsync: this);

          _controller!.addListener(() {
            context.read<TestsliverCubit>().setImagePath(_controller!.index);
          });
          return snapshot.hasData
              ? Scaffold(
                  appBar: AppBar(
                    elevation: 12,
                    leading: Builder(builder: (BuildContext context) {
                      return IconButton(
                        icon: Image.asset('images/fluenzologo.png'),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    }),
                    title: Text(
                      appName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                                create: (context) =>
                                                    ArticleCubit()),
                                            BlocProvider(
                                                create: (context) =>
                                                    SearchcubitCubit())
                                          ],
                                          child: SearchArticleScreen(),
                                        )));
                          },
                          icon: Icon(Icons.search))
                    ],
                  ),
                  body: SafeArea(
                    child: NestedScrollView(
                        headerSliverBuilder: (context, value) {
                          return [
                            SliverAppBar(
                                leading: Container(),
                                flexibleSpace: BlocBuilder<TestsliverCubit,
                                    TestsliverState>(
                                  builder: (context, state) {
                                    print('nnn state ${state.photoUrl}');
                                    return FlexibleSpaceBar(
                                      background: Opacity(
                                        opacity: 0.225,
                                        child: CachedNetworkImage(
                                          imageUrl: list
                                              .elementAt(state.photoUrl!)
                                              .photo!,
                                          //list.iterator.current.photo!,
                                          //state.photoUrl!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                backgroundColor: Colors.white,
                                expandedHeight: 150,
                                pinned: true,
                                floating: true,
                                bottom: TabBar(
                                  unselectedLabelStyle: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                  indicatorColor: Colors.black,
                                  isScrollable: true,
                                  labelColor: Colors.red,
                                  unselectedLabelColor: Colors.black,
                                  controller: _controller,
                                  tabs: list.map((e) {
                                    //  testSliver.setImagePath(e.photo);
                                    return e.tab!;
                                  }).toList(),
                                ))
                          ];
                        },
                        body: TabBarView(
                          controller: _controller,
                          children: list.map((e) {
                            print('nnn tab working');
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('ArticlesCollection')
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            ArticlesModel model =
                                                ArticlesModel.fromJson(
                                                    snapshot.data.docs[index]);
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MultiBlocProvider(
                                                                providers: [
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          ArticlesdetailCubit()),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          ArticlelikeCubit()),
                                                                  BlocProvider(
                                                                    create: (context) =>
                                                                        ArticlereportCubit(),
                                                                  ),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          CheckuserloginedCubit()),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          DetailviewdynamiclinkCubit()),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          CommentStreamCubit()),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          ArticletitleCubit()),
                                                                  BlocProvider(
                                                                      create: (context) =>
                                                                          BookmarkCubit()),
                                                                ],
                                                                child:
                                                                    ArticlesDetailViewScreen(
                                                                  fromReviewOrReject:
                                                                      false,
                                                                  documentId:
                                                                      snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                  fromNotification:
                                                                      false,
                                                                  fromEdit:
                                                                      false,
                                                                ),
                                                              )));
                                                },
                                                child: model.articleSubType ==
                                                        e.tab!.text
                                                    ? BlocProvider(
                                                        create: (context) =>
                                                            CheckuserloginedCubit(),
                                                        child: ArticleCard(
                                                          model: model,
                                                          docid: snapshot.data
                                                              .docs[index].id,
                                                          title: model
                                                              .articletitle!,
                                                          desc: model
                                                              .articledesc!,
                                                        ))
                                                    : Container());
                                          },
                                        )
                                      : Center(
                                          child: CircularProgressIndicator());
                                });
                          }).toList(),
                        )),
                  ))
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}

class TabData {
  Tab? tab;
  String? photo;

  TabData({this.tab, this.photo});
}

//import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      print("Selected Index: " + _controller!.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              _controller!.index.toString(),
              //_selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
          ],
        ),
      ),
    );
  }
}
*/