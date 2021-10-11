import 'package:cached_network_image/cached_network_image.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookmarkScreenCubit/bookmarkscreen_cubit.dart';
import '/ArticleDetailView/Screen/BookmarkedArticlesScreen.dart';
import '/Common/Constant/Constants.dart';
import '/HomeScreen/Bloc/DrawerNameCubit/drawername_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //final uiSwapCubit = BlocProvider.of<ArticleswapCubit>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
//        color: Colors.red,
          width: getWidth(context),
          height: getHeight(context) * 0.98,
          child: Column(
            children: [
              BlocBuilder<DrawernameCubit, DrawernameState>(
                builder: (context, state) {
                  return Container(
                    width: getWidth(context),
                    height: getHeight(context) * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: getWidth(context) * 0.25,
                          height: getWidth(context) * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    'https://picsum.photos/200'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(height: getWidth(context) * 0.035),
                        Container(
                            child: Text(state.drawerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold))),
                        SizedBox(height: getWidth(context) * 0.015),
                        /*Container(
                            child: Text('12/12/1998',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(height: getWidth(context) * 0.015),*/
                        Container(
                            child: Text(state.drawerEmail,
                                style: Theme.of(context).textTheme.bodyText1))
                      ],
                    ),
                  );
                },
              ),

              SizedBox(
                height: getWidth(context) * 0.15,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Article',
                      ),
                      Tab(
                        text: 'Favourite Article',
                      ),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      //color: Colors.blue,
                      width: getWidth(context),
                      height: getWidth(context) * 0.93,
                      //color: Colors.brown,
                      child: Center(child: Text('Article Screen')),
                    ),
                    // first tab bar view widget
                    Container(
                      width: getWidth(context),
                      height: getWidth(context) * 0.93,
                      //color: Colors.brown,
                      child: MultiBlocProvider(providers: [
                        BlocProvider(
                            create: (context) => BookmarkscreenCubit()),
                      ], child: BookmarkedArticlesScreen()),
                    ),

                    // second tab bar viiew widget
                  ],
                ),
              ),

              /*        BlocBuilder<ArticleswapCubit, ArticleswapState>(
                builder: (context, state) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          width: getWidth(context),
                          height: getWidth(context) * 0.15,
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          uiSwapCubit.tapOnArticle();
                                        },
                                        child: Text('Articles',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6)),
                                    TextButton(
                                        onPressed: () {
                                          uiSwapCubit.tapOnSaved();
                                        },
                                        child: Text('Saved',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6)),
                                  ]),
                              Container(
                                height: getWidth(context) * 0.015,
                                child: Stack(children: [
                                  state.articlesSwap
                                      ? Container()
                                      : Positioned(
                                          top: getWidth(context) * 0.001,
                                          left: getWidth(context) * 0.15,
                                          child: Container(
                                              width: getWidth(context) * 0.3,
                                              height: getWidth(context) * 0.01,
                                              color: Colors.red),
                                        ),
                                  state.articlesSwap
                                      ? Positioned(
                                          top: getWidth(context) * 0.001,
                                          right: getWidth(context) * 0.14,
                                          child: Container(
                                              width: getWidth(context) * 0.3,
                                              height: getWidth(context) * 0.01,
                                              color: Colors.red),
                                        )
                                      : Container(),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: getWidth(context) * 0.03),
                        state.articlesSwap
                            ? Container(
                                width: getWidth(context),
                                height: getWidth(context) * 0.93,
                                //color: Colors.brown,
                                child: MultiBlocProvider(providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          BookmarkscreenCubit()),
                                ], child: BookmarkedArticlesScreen()),
                              )
                            : Container(
                                //color: Colors.blue,
                                width: getWidth(context),
                                height: getWidth(context) * 0.93,
                                //color: Colors.brown,
                                child: Center(child: Text('Article Screen')),
                              )
                      ],
                    ),
                  );
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
