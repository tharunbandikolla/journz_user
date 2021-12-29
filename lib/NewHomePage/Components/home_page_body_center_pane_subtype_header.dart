import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journz_web/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

class BodyCenterPaneSubtypeHeader extends StatefulWidget {
  final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit;
  const BodyCenterPaneSubtypeHeader(
      {Key? key, required this.showCurrentSubtypeNameCubit})
      : super(key: key);

  @override
  _BodyCenterPaneSubtypeHeaderState createState() =>
      _BodyCenterPaneSubtypeHeaderState();
}

class _BodyCenterPaneSubtypeHeaderState
    extends State<BodyCenterPaneSubtypeHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowCurrentlySelectedSubtypeCubit,
        ShowCurrentlySelectedSubtypeState>(
      builder: (context, currentSubtypeState) {
        return Container(
          padding: EdgeInsets.only(left: context.screenWidth * 0.0225),
          width: context.screenWidth * 0.6,
          height: context.screenHeight * 0.125,
          child: ValueListenableBuilder<Box<HiveArticlesSubtypes>>(
            valueListenable: Boxes.getArticleSubtypeFromCloud().listenable(),
            builder: (context, value, _) {
              final subtype =
                  value.values.toList().cast<HiveArticlesSubtypes>();

              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: subtype.length + 1,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 0.125,
                    width: context.screenWidth * 0.025,
                  );
                },
                itemBuilder: (context, index) {
                  return index == 0
                      ? InkWell(
                          onTap: () {
                            widget.showCurrentSubtypeNameCubit
                                .changeSelectedSubtypeTo('All');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: context.screenWidth * 0.045,
                                height: context.screenHeight * 0.085,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: context.screenWidth * 0.002,
                                        color: currentSubtypeState
                                                    .selectedSubtype! ==
                                                'All'
                                            ? Colors.blue
                                            : Colors.black),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            'https://picsum.photos/200'))),
                              ),
                              SizedBox(height: context.screenHeight * 0.001),
                              Text(
                                'All',
                                style: TextStyle(
                                    fontWeight:
                                        currentSubtypeState.selectedSubtype! ==
                                                'All'
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              )
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            widget.showCurrentSubtypeNameCubit
                                .changeSelectedSubtypeTo(
                                    subtype[index - 1].subtypeName);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: context.screenWidth * 0.045,
                                height: context.screenHeight * 0.085,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: context.screenWidth * 0.002,
                                        color: currentSubtypeState
                                                    .selectedSubtype! ==
                                                subtype[index - 1].subtypeName
                                            ? Colors.blue
                                            : Colors.black),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            subtype[index - 1].photoUrl))),
                              ),
                              SizedBox(height: context.screenHeight * 0.001),
                              Text(
                                subtype[index - 1].subtypeName,
                                style: TextStyle(
                                    fontWeight:
                                        currentSubtypeState.selectedSubtype! ==
                                                subtype[index - 1].subtypeName
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              )
                            ],
                          ),
                        );
                },
              );
            },
          ),
        );
      },
    );
  }
}
