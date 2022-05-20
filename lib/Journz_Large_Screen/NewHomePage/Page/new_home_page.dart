import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Components/footer.dart';
import '/Journz_Large_Screen/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';

import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';

import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import 'package:velocity_x/velocity_x.dart';

import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_center_pane.dart';

class Home extends StatefulWidget {
  final bool? wantSearchBar;
  final String? showFavCategory;
  const Home(
      {Key? key, required this.wantSearchBar, required this.showFavCategory})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    //print('nnn MAin Char ${widget.showFavCategory}');
    //context.read<CheckuserloginedCubit>().checkLogin();
    // checkConnection();

    context.read<CheckuserloginedCubit>().checkLogin();
    /* showCurrentlySelectedSubtypeCubit =
        context.read<ShowCurrentlySelectedSubtypeCubit>(); */
    super.didChangeDependencies();
  }

  checkConnection() async {
    //  ConnectivityResult event = await Connectivity().checkConnectivity();
    // if (event != ConnectivityResult.none) {
    getDataFromDB();
    //}
  }

  getDataFromDB() {
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
  }

  @override
  Widget build(BuildContext context) {
    // getDataFromDB();
    context.read<CheckuserloginedCubit>().checkLogin();
    return Scaffold(
      body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
        builder: (context, userState) {
          /*   if (userState.isLoggined!) {
            print("Notification Uid ${userState.userUid!}");
            // updateWebNotificationToken(userState.userUid!);
          } */
          return Container(
            height: context.screenHeight,
            width: context.screenWidth,
            child: Column(
              children: [
                //SaiHeader(),
                HomePageHeader(wantSearchBar: true, fromMobile: false),
                SizedBox(height: context.screenHeight * 0.015),
                BlocProvider(
                  create: (context) => ShowCurrentlySelectedSubtypeCubit(
                      userState: userState.isLoggined!),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //HomePageHeader(wantSearchBar: widget.wantSearchBar),
                        Container(
                          width: context.screenWidth,
                          //height: context.screenHeight * 0.865,
                          //color: Colors.white,
                          child: BodyCenterPane(
                            swapFavCatName: widget.showFavCategory,
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
  }

  @override
  void dispose() {
    //  Hive.close();
    super.dispose();
  }
}
