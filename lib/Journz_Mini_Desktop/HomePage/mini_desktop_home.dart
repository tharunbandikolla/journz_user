import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Journz_Large_Screen/NewHomePage/Components/footer.dart';
import '/Journz_Large_Screen/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';

import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';

import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'mini_desktop_home_page_body_center_pane.dart';
import 'mini_desktop_home_page_header.dart';

class MiniDeskHome extends StatefulWidget {
  final bool? wantSearchBar;
  const MiniDeskHome({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MiniDeskHome> {
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
    /*  ConnectivityResult event = await Connectivity().checkConnectivity();
    if (event != ConnectivityResult.none) { */
    getDataFromDB();
    /* } */
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
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
        builder: (context, userState) {
          return Container(
            height: context.screenHeight,
            width: context.screenWidth,
            child: Column(
              children: [
                //SaiHeader(),
                MiniDeskHomePageHeader(wantSearchBar: true),
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
                          child: MiniDeskBodyCenterPane(
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
