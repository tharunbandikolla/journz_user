import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileBodyCenterPaneSubtypeHeader extends StatefulWidget {
  //final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit;
  const MobileBodyCenterPaneSubtypeHeader({
    Key? key,
    /* required this.showCurrentSubtypeNameCubit */
  }) : super(key: key);

  @override
  _BodyCenterPaneSubtypeHeaderState createState() =>
      _BodyCenterPaneSubtypeHeaderState();
}

class _BodyCenterPaneSubtypeHeaderState
    extends State<MobileBodyCenterPaneSubtypeHeader> {
  int all = 0;
  int favourite = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowCurrentlySelectedSubtypeCubit,
        ShowCurrentlySelectedSubtypeState>(
      builder: (context, currentSubtypeState) {
        return BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
          builder: (context, userState) {
            if (userState.isLoggined!) {
              all = 1;
              favourite = 0;
            } else {
              all = 0;
              favourite = 1;
            }
            return Container(
              // padding: EdgeInsets.only(left: context.screenWidth * 0.0225),
              padding: EdgeInsets.symmetric(horizontal: 5),

              width: context.screenWidth,
              height: context.screenHeight * 0.13,

              child: ValueListenableBuilder<Box<HiveArticlesSubtypes>>(
                valueListenable:
                    Boxes.getArticleSubtypeFromCloud().listenable(),
                builder: (context, value, _) {
                  final subtype =
                      value.values.toList().cast<HiveArticlesSubtypes>();

                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: userState.isLoggined!
                        ? subtype.length + 2
                        : subtype.length + 1,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 0.125,
                        width: context.screenWidth * 0.02,
                      );
                    },
                    itemBuilder: (context, index) {
                      return index == all
                          ? InkWell(
                              onTap: () {
                                //widget.showCurrentSubtypeNameCubit
                                context
                                    .read<ShowCurrentlySelectedSubtypeCubit>()
                                    .changeSelectedSubtypeTo('All');
                              },
                              child:
                                  /*Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: context.screenWidth * 0.045,
                                    height: context.screenHeight * 0.085,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: context.screenWidth * 0.002,
                                            color: currentSubtypeState
                                                        .selectedSubtype ==
                                                    'All'
                                                ? Colors.blue
                                                : Colors.black),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                'https://picsum.photos/200'))),
                                  ),
                                  SizedBox(
                                      height: context.screenHeight * 0.001),
                                  Text(
                                    'All',
                                    style: TextStyle(
                                        fontWeight: currentSubtypeState
                                                    .selectedSubtype ==
                                                'All'
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  )
                                ],
                              )*/
                                  headeritem(
                                      currentSubtypeState.selectedSubtype,
                                      'All',
                                      'https://picsum.photos/200'))
                          : userState.isLoggined!
                              ? index == favourite
                                  ? InkWell(
                                      onTap: () {
                                        //  widget.showCurrentSubtypeNameCubit
                                        context
                                            .read<
                                                ShowCurrentlySelectedSubtypeCubit>()
                                            .changeSelectedSubtypeTo(
                                                'Favourites');
                                      },
                                      child:
                                          /*Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: context.screenWidth * 0.045,
                                            height:
                                                context.screenHeight * 0.085,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: context.screenWidth *
                                                        0.002,
                                                    color: currentSubtypeState
                                                                .selectedSubtype ==
                                                            'Favourites'
                                                        ? Colors.blue
                                                        : Colors.black),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                        'https://picsum.photos/100'))),
                                          ),
                                          SizedBox(
                                              height:
                                                  context.screenHeight * 0.001),
                                          Text(
                                            'Favourites',
                                            style: TextStyle(
                                                fontWeight: currentSubtypeState
                                                            .selectedSubtype ==
                                                        'Favourites'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )
                                        ],
                                      )*/
                                          headeritem(
                                              currentSubtypeState
                                                  .selectedSubtype,
                                              'Favourites',
                                              'https://picsum.photos/100'),
                                    )
                                  : InkWell(
                                      onDoubleTap: () {
                                        if (userState.isLoggined!) {
                                          List<dynamic> favs = [];
                                          FirebaseFirestore.instance
                                              .collection('UserProfile')
                                              .doc(userState.userUid)
                                              .get()
                                              .then((value) {
                                            favs = value.data()![
                                                'UsersFavouriteArticleCategory'];

                                            if (favs.contains(subtype[index - 2]
                                                .subtypeName)) {
                                              FirebaseFirestore.instance
                                                  .collection('UserProfile')
                                                  .doc(userState.userUid)
                                                  .update({
                                                'UsersFavouriteArticleCategory':
                                                    FieldValue.arrayRemove([
                                                  subtype[index - 2].subtypeName
                                                ])
                                              });
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection('UserProfile')
                                                  .doc(userState.userUid)
                                                  .update({
                                                'UsersFavouriteArticleCategory':
                                                    FieldValue.arrayUnion([
                                                  subtype[index - 2].subtypeName
                                                ])
                                              });
                                            }
                                          });
                                        }
                                      },
                                      onTap: () {
                                        //widget.showCurrentSubtypeNameCubit
                                        context
                                            .read<
                                                ShowCurrentlySelectedSubtypeCubit>()
                                            .changeSelectedSubtypeTo(userState
                                                    .isLoggined!
                                                ? subtype[index - 2].subtypeName
                                                : subtype[index - 1]
                                                    .subtypeName);
                                      },
                                      child:
                                          /*Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: context.screenWidth * 0.045,
                                            height:
                                                context.screenHeight * 0.085,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: context.screenWidth *
                                                        0.002,
                                                    color: currentSubtypeState
                                                                .selectedSubtype ==
                                                            subtype[userState.isLoggined! ? index - 2 : index - 1]
                                                                .subtypeName
                                                        ? Colors.blue
                                                        : Colors.black),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                        subtype[userState.isLoggined!
                                                                ? index - 2
                                                                : index - 1]
                                                            .photoUrl))),
                                          ),
                                          SizedBox(
                                              height:
                                                  context.screenHeight * 0.001),
                                          Text(
                                            subtype[userState.isLoggined!
                                                    ? index - 2
                                                    : index - 1]
                                                .subtypeName,
                                            style: TextStyle(
                                                fontWeight: currentSubtypeState
                                                            .selectedSubtype ==
                                                        subtype[userState
                                                                    .isLoggined!
                                                                ? index - 2
                                                                : index - 1]
                                                            .subtypeName
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )
                                        ],
                                      )*/
                                          headeritem(
                                              currentSubtypeState
                                                  .selectedSubtype,
                                              subtype[userState.isLoggined!
                                                      ? index - 2
                                                      : index - 1]
                                                  .subtypeName,
                                              subtype[userState.isLoggined!
                                                      ? index - 2
                                                      : index - 1]
                                                  .photoUrl),
                                    )
                              : InkWell(
                                  onDoubleTap: () {
                                    if (userState.isLoggined!) {
                                      List<dynamic> favs = [];
                                      FirebaseFirestore.instance
                                          .collection('UserProfile')
                                          .doc(userState.userUid)
                                          .get()
                                          .then((value) {
                                        favs = value.data()![
                                            'UsersFavouriteArticleCategory'];

                                        if (favs.contains(
                                            subtype[index - 2].subtypeName)) {
                                          FirebaseFirestore.instance
                                              .collection('UserProfile')
                                              .doc(userState.userUid)
                                              .update({
                                            'UsersFavouriteArticleCategory':
                                                FieldValue.arrayRemove([
                                              subtype[index - 2].subtypeName
                                            ])
                                          });
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('UserProfile')
                                              .doc(userState.userUid)
                                              .update({
                                            'UsersFavouriteArticleCategory':
                                                FieldValue.arrayUnion([
                                              subtype[index - 2].subtypeName
                                            ])
                                          });
                                        }
                                      });
                                    }
                                  },
                                  onTap: () {
                                    //widget.showCurrentSubtypeNameCubit
                                    context
                                        .read<
                                            ShowCurrentlySelectedSubtypeCubit>()
                                        .changeSelectedSubtypeTo(userState
                                                .isLoggined!
                                            ? subtype[index - 2].subtypeName
                                            : subtype[index - 1].subtypeName);
                                  },
                                  child:
                                      /*Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: context.screenWidth * 0.045,
                                        height: context.screenHeight * 0.085,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width:
                                                    context.screenWidth * 0.002,
                                                color: currentSubtypeState
                                                            .selectedSubtype ==
                                                        subtype[userState
                                                                    .isLoggined!
                                                                ? index - 2
                                                                : index - 1]
                                                            .subtypeName
                                                    ? Colors.blue
                                                    : Colors.black),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: CachedNetworkImageProvider(
                                                    subtype[userState.isLoggined! ? index - 2 : index - 1]
                                                        .photoUrl))),
                                      ),
                                      SizedBox(
                                          height: context.screenHeight * 0.001),
                                      Text(
                                        subtype[userState.isLoggined!
                                                ? index - 2
                                                : index - 1]
                                            .subtypeName,
                                        style: TextStyle(
                                            fontWeight: currentSubtypeState
                                                        .selectedSubtype ==
                                                    subtype[userState
                                                                .isLoggined!
                                                            ? index - 2
                                                            : index - 1]
                                                        .subtypeName
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )
                                    ],
                                  )*/
                                      headeritem(
                                          currentSubtypeState.selectedSubtype,
                                          subtype[userState.isLoggined!
                                                  ? index - 2
                                                  : index - 1]
                                              .subtypeName,
                                          subtype[userState.isLoggined!
                                                  ? index - 2
                                                  : index - 1]
                                              .photoUrl),
                                );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

Widget headeritem(String selectedSubtype, String a, String image) {
  return Builder(builder: (context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          //width: context.screenWidth * 0.1,
          width: 40,

          height: context.screenHeight * 0.085,
          decoration: BoxDecoration(
              border: Border.all(
                  width: context.screenWidth * 0.002,
                  color: selectedSubtype == a ? Colors.blue : Colors.black),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: CachedNetworkImageProvider(image))),
        ),
        SizedBox(height: context.screenHeight * 0.001),
        Text(
          a,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight:
                  selectedSubtype == a ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  });
}
