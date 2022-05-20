import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Journz_Tab/tab_home_footer.dart';
import 'package:journz_web/Journz_Tab/tab_home_page_body_center_pane.dart';
import 'package:journz_web/Journz_Tab/tab_home_page_header.dart';
import '../Journz_Large_Screen/NewHomePage/Components/footer.dart';
import '../Journz_Large_Screen/utils/routes.dart';
import '../Journz_Mini_Desktop/HomePage/tab_app_drawer.dart';
import '../Journz_Mobile/HomePage/mobile_app_drawer.dart';
import '/Journz_Large_Screen/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import 'package:velocity_x/velocity_x.dart';

class TabHome extends StatefulWidget {
  final bool? wantSearchBar;
  const TabHome({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<TabHome> {
  //late ShowCurrentlySelectedSubtypeCubit showCurrentlySelectedSubtypeCubit;

  @override
  void didChangeDependencies() {
    //context.read<CheckuserloginedCubit>().checkLogin();
    // checkConnection();
    /* showCurrentlySelectedSubtypeCubit =
        context.read<ShowCurrentlySelectedSubtypeCubit>(); */
    super.didChangeDependencies();
  }

  checkConnection() async {
    getDataFromDB();
  }

  getDataFromDB() {
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
  }

  @override
  Widget build(BuildContext context) {
    // getDataFromDB();
    context.read<CheckuserloginedCubit>().checkLogin();
    return BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
      builder: (context, userState) {
        return Scaffold(
          drawerEdgeDragWidth: 0,
          drawer: TabDrawer(
              userState:
                  userState) /* Drawer(
            //        backgroundColor: Colors.blue.shade400,
            child: Column(children: [
              userState.isLoggined!
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/TabSignUp"}),
                        );
                      },
                      child: Text("Sign Up")),
              userState.isLoggined!
                  ? ElevatedButton(
                      onPressed: () {
                        if (userState.isLoggined!) {
                          FirebaseAuth.instance.signOut().then((value) =>
                              context
                                  .read<CheckuserloginedCubit>()
                                  .checkLogin());
                        }
                      },
                      child: Text("Sign Out"))
                  : Container(),
              userState.isLoggined!
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/TabLogin"}),
                        );
                      },
                      child: Text("Login"))
            ]),
          ) */
          ,
          body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, userState) {
              return Container(
                height: context.screenHeight,
                width: context.screenWidth,
                child: Column(
                  children: [
                    //SaiHeader(),
                    TabHomePageHeader(wantSearchBar: true),
                    SizedBox(height: context.screenHeight * 0.015),
                    BlocProvider(
                      create: (context) => ShowCurrentlySelectedSubtypeCubit(
                          userState: userState.isLoggined!),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //HomePageHeader(wantSearchBar: widget.wantSearchBar),
                            Container(
                              width: context.screenWidth,
                              //height: context.screenHeight * 0.865,
                              //color: Colors.white,
                              child: TabBodyCenterPane(
                                  /* showCurrentSubtypeNameCubit: context
                                        .read<ShowCurrentlySelectedSubtypeCubit>(), */
                                  ),
                            ),
                            SizedBox(height: context.screenHeight * 0.03),

                            CommonHomePageFooter()
                          ],
                        ),
                      ),
                    )
                        .box
                        .width(context.screenWidth)
                        .height(context.screenHeight * 0.9)
                        .make(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    //  Hive.close();
    super.dispose();
  }
}
