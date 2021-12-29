import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:journz_web/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';
import '/NewHomePage/Components/home_page_body_right_pane.dart';
import '/NewHomePage/Components/home_page_footer.dart';
import '/NewHomePage/Components/home_page_header.dart';

import 'package:velocity_x/velocity_x.dart';
import '/NewHomePage/Components/home_page_body_left_pane.dart';
import '/NewHomePage/Components/home_page_body_center_pane.dart';

class Home extends StatefulWidget {
  final bool? wantSearchBar;
  const Home({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ShowCurrentlySelectedSubtypeCubit showCurrentlySelectedSubtypeCubit;

  @override
  void didChangeDependencies() {
    context.read<CheckuserloginedCubit>().checkLogin();
    checkConnection();
    showCurrentlySelectedSubtypeCubit =
        context.read<ShowCurrentlySelectedSubtypeCubit>();
    super.didChangeDependencies();
  }

  checkConnection() async {
    ConnectivityResult event = await Connectivity().checkConnectivity();
    if (event != ConnectivityResult.none) {
      getDataFromDB();
    }
  }

  getDataFromDB() {
    print('nnn getting articles only when internet');
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageHeader(wantSearchBar: widget.wantSearchBar),
            Container(
              width: context.screenWidth,
              height: context.screenHeight * 0.865,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyLeftPane(),
                  BodyCenterPane(
                    showCurrentSubtypeNameCubit:
                        showCurrentlySelectedSubtypeCubit,
                  ),
                  BodyRightPane()
                ],
              ),
            ),
            HomePageFooter()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //  Hive.close();
    super.dispose();
  }
}
