import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '../../Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '../../Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/get_subtype_in_article_creation_cubit/get_subtype_in_article_creation_cubit.dart';
import '/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';

import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:random_string/random_string.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/AddLinkUrlCubit/add_link_url_cubit.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/render_selected_subtype_name_cubit/render_selected_subtype_name_cubit.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/stepper_cubit/stepper_cubit.dart';
import '/Journz_Large_Screen/Add_Articles/model/article_creation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileArticleCreationScreen extends StatefulWidget {
  final bool IsEditArticle;
  final CodeArticleData articleData;
  const MobileArticleCreationScreen(
      {Key? key, required this.IsEditArticle, required this.articleData})
      : super(key: key);

  @override
  _MobileArticleCreationScreenState createState() =>
      _MobileArticleCreationScreenState();
}

class _MobileArticleCreationScreenState
    extends State<MobileArticleCreationScreen> {
  int i = 0;
  //List<String> subItems = [];
  List<String> subitem = [];
  String? subTypeName;
  String? photoString;
  String? title;
  String? shortDesc;
  String? desciption;
  String? authorName;
  String? authorUid;
  String? documentId;

  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  HtmlEditorController descController = HtmlEditorController();
  TextEditingController linktext = TextEditingController();
  TextEditingController linkUrl = TextEditingController();

  var v;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.IsEditArticle} and ${widget.articleData}");
    final checkUserLoggedIn = BlocProvider.of<CheckuserloginedCubit>(context);
    checkUserLoggedIn.checkLogin();
    final stepperCubit = BlocProvider.of<StepperCubit>(context);
    final addPhotoCubit = BlocProvider.of<AddphotoarticleCubit>(context);
    final subTypenameRenderCubit =
        BlocProvider.of<RenderSelectedSubtypeNameCubit>(context);
    final passSubtypeData =
        BlocProvider.of<GetSubtypeInArticleCreationCubit>(context);

    final addLinkCubit = BlocProvider.of<AddLinkUrlCubit>(context);

    return Scaffold(
        body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
      builder: (context, authorNameState) {
        if (widget.IsEditArticle) {
          if (authorNameState.isLoggined!) {
            context
                .read<RenderSelectedSubtypeNameCubit>()
                .getSelectedSubtype(widget.articleData.articleSubtype);
            if (widget.articleData.articlePhotoUrl != "WithoutImage") {
              context
                  .read<AddphotoarticleCubit>()
                  .givePhotoUrl(widget.articleData.articlePhotoUrl!, true);
            } else {
              context
                  .read<AddphotoarticleCubit>()
                  .givePhotoUrl(widget.articleData.articlePhotoUrl!, false);
            }
            authorName = widget.articleData.authorName;
            print(widget.articleData.authorName);
            authorUid = widget.articleData.authorUid!;
            print(widget.articleData.authorUid!);
            documentId = widget.articleData.documentId;
            print(widget.articleData.documentId);
            subTypeName = widget.articleData.articleSubtype;
            print(widget.articleData.articleSubtype);
            photoString = widget.articleData.articlePhotoUrl;
            print(widget.articleData.articlePhotoUrl);
            title = widget.articleData.articleTitle;
            print(widget.articleData.articleTitle);
            desciption = widget.articleData.articleDescription;
            print(widget.articleData.articleDescription);
            titleController.text = widget.articleData.articleTitle!;
            shortDescController.text = widget.articleData.shortDescription!;
            print(widget.articleData.articleTitle!);
            authorController.text = widget.articleData.authorName!;
            print(widget.articleData.authorName!);
            //descController.insertHtml(widget.articleData.articleDescription!);
            //   descController.setText(widget.articleData.articleDescription!);

            print(widget.articleData.socialMediaLink!);
            print(widget.articleData.articleDescription!);
            linkUrl.text = widget.articleData.socialMediaLink!;
            final subtype = Boxes.getArticleSubtypeFromCloud();

            subtype.values.forEach((element) {
              subitem.add(element.subtypeName);
              passSubtypeData.getData(subitem);
            });
          }
        } else {
          if (authorNameState.isLoggined!) {
            authorName = authorNameState.name!;
            authorUid = authorNameState.userUid!;
            documentId = randomAlphaNumeric(20);
            final subtype = Boxes.getArticleSubtypeFromCloud();

            subtype.values.forEach((element) {
              subitem.add(element.subtypeName);
              passSubtypeData.getData(subitem);
            });
          }
        }

        return authorNameState.isLoggined!
            ? authorNameState.name!.isNotEmpty
                ? BlocBuilder<StepperCubit, StepperState>(
                    builder: (context, stepperState) {
                      print('nnnn ${stepperState.steps!}');
                      i = stepperState.steps!;

                      return SingleChildScrollView(
                        child: Container(
                          height: context.screenWidth * 2.25,
                          width: context.screenWidth,
                          child: Column(
                            children: [
                              HomePageHeader(
                                  wantSearchBar: false, fromMobile: true),
                              SizedBox(height: context.screenWidth * 0.015),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: context.screenWidth,
                                      height: context.screenWidth * 0.01),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black.withOpacity(0.3),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 8,
                                    child: "Add New Articles"
                                        .text
                                        .xl2
                                        .bold
                                        .make()
                                        .box
                                        .alignCenterLeft
                                        .px20
                                        .width(context.screenWidth * 0.95)
                                        .height(context.screenWidth * 0.125)
                                        .make(),
                                  ),
                                  SizedBox(
                                      width: context.screenWidth,
                                      height: context.screenWidth * 0.01),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            stepperState.steps! == 1
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Select Category"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container(),
                                            stepperState.steps! == 2
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Add Photo"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container(),
                                            stepperState.steps! == 3
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Add Title"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container(),
                                            stepperState.steps! == 4
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Add Short Description"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container(),
                                            stepperState.steps! == 5
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Add Description"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container(),
                                            stepperState.steps! == 6
                                                ? Row(
                                                    children: [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                      SizedBox(width: 20),
                                                      "Create"
                                                          .text
                                                          .xl
                                                          .green600
                                                          .make()
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        )
                                            .box
                                            .width(context.screenWidth * 0.95)
                                            .alignCenter
                                            .height(context.screenWidth * 0.15)
                                            .make(),
                                      ).box.make(),
                                      SizedBox(
                                        width: context.screenWidth * 0.005,
                                      ),
                                      Card(
                                        elevation: 4,
                                        child: Container(
                                          width: context.screenWidth * 0.95,
                                          height: context.screenWidth * 1.6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              stepperState.steps! == 1
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        "Please Select The Subtype For Your Article"
                                                            .text
                                                            .semiBold
                                                            .make(),
                                                        BlocBuilder<
                                                                GetSubtypeInArticleCreationCubit,
                                                                GetSubtypeInArticleCreationState>(
                                                          builder: (context,
                                                              subtypeState) {
                                                            return BlocBuilder<
                                                                    RenderSelectedSubtypeNameCubit,
                                                                    RenderSelectedSubtypeNameState>(
                                                                builder: (context,
                                                                    renderSubtypeState) {
                                                              if (renderSubtypeState
                                                                      .selectedSubtype !=
                                                                  null) {
                                                                subTypeName =
                                                                    renderSubtypeState
                                                                        .selectedSubtype;
                                                              }

                                                              return subtypeState
                                                                      .subtypes!
                                                                      .isNotEmpty
                                                                  ? DropdownButton<
                                                                          String>(
                                                                      dropdownColor:
                                                                          Colors
                                                                              .white,
                                                                      isExpanded:
                                                                          true,
                                                                      hint: Text(
                                                                          'Select A Subtype'),
                                                                      value: renderSubtypeState
                                                                          .selectedSubtype,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        subTypenameRenderCubit
                                                                            .getSelectedSubtype(value);
                                                                      },
                                                                      items: subtypeState
                                                                          .subtypes!
                                                                          .map<DropdownMenuItem<String>>((value) =>
                                                                              DropdownMenuItem<String>(
                                                                                value: value,
                                                                                child: Text(value),
                                                                              ))
                                                                          .toList())
                                                                  : Center(
                                                                      child: "Loading..."
                                                                          .text
                                                                          .xl
                                                                          .semiBold
                                                                          .make(),
                                                                    );
                                                            });
                                                          },
                                                        )
                                                            .box
                                                            .width(context
                                                                    .screenWidth *
                                                                0.75)
                                                            .height(context
                                                                    .screenWidth *
                                                                0.15)
                                                            .make(),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                stepperState.steps! >
                                                                            1 &&
                                                                        stepperState.steps! <
                                                                            6
                                                                    ? ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          i--;
                                                                          stepperCubit
                                                                              .trackSteps(i);
                                                                        },
                                                                        child: Text(
                                                                            'Back'))
                                                                    : Container(),
                                                                SizedBox(
                                                                  width: context
                                                                          .screenWidth *
                                                                      0.005,
                                                                ),
                                                                stepperState.steps! ==
                                                                        6
                                                                    ? ElevatedButton(
                                                                        onPressed:
                                                                            () {},
                                                                        child: Text(
                                                                            'Upload'))
                                                                    : Container(),
                                                                stepperState.steps! <
                                                                        6
                                                                    ? ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          if (subTypeName !=
                                                                              null) {
                                                                            i++;
                                                                            stepperCubit.trackSteps(i);
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select Category For Your Article')));
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            'Next'))
                                                                    : Container(),
                                                                SizedBox(
                                                                    width: 20)
                                                              ])
                                                              .box
                                                              .width(context
                                                                      .screenWidth *
                                                                  0.95)
                                                              .make(),
                                                        )
                                                      ],
                                                    )
                                                      .box
                                                      .p12
                                                      .width(
                                                          context.screenWidth *
                                                              0.95)
                                                      .height(
                                                          context.screenWidth)
                                                      .make()
                                                  : stepperState.steps! == 2
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            "Please Select A Photo For Article (Optional)"
                                                                .text
                                                                .xl
                                                                .semiBold
                                                                .make(),
                                                            "If you selected an Image please wait till it appears on the Screen"
                                                                .text
                                                                .xl
                                                                .semiBold
                                                                .make(),
                                                            BlocBuilder<
                                                                    AddphotoarticleCubit,
                                                                    AddphotoarticleState>(
                                                              builder: (context,
                                                                  addPhotoState) {
                                                                photoString =
                                                                    addPhotoState
                                                                        .photoURL;
                                                                //"https://firebasestorage.googleapis.com/v0/b/journzsocialnetwork.appspot.com/o/Articles%2FMind-Set%2Fimage_cropper_1636222654939.jpg?alt=media&token=72104bf6-2e02-4153-b87f-9575e6f5df6c";

                                                                return InkWell(
                                                                  onTap: () {
                                                                    addPhotoCubit
                                                                        .uploadToStorage(
                                                                            subTypeName!);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: context
                                                                            .screenWidth *
                                                                        0.95,
                                                                    height: context
                                                                            .screenWidth *
                                                                        1.25,
                                                                    decoration: BoxDecoration(
                                                                        image: !addPhotoState.isPhotoUploaded!
                                                                            ? DecorationImage(
                                                                                fit: BoxFit.cover,
                                                                                image: AssetImage('assets/images/add_photo.png'))
                                                                            : DecorationImage(image: NetworkImage(addPhotoState.photoURL!))),
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                                .box
                                                                .width(context
                                                                        .screenWidth *
                                                                    0.5)
                                                                .height(context
                                                                        .screenWidth *
                                                                    0.5)
                                                                .makeCentered(),
                                                            SizedBox(
                                                              width: context
                                                                  .screenWidth,
                                                              height: context
                                                                      .screenWidth *
                                                                  0.035,
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                    stepperState.steps! >
                                                                                1 &&
                                                                            stepperState.steps! <
                                                                                6
                                                                        ? ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              i--;
                                                                              stepperCubit.trackSteps(i);
                                                                            },
                                                                            child:
                                                                                Text('Back'))
                                                                        : Container(),
                                                                    SizedBox(
                                                                      width: context
                                                                              .screenWidth *
                                                                          0.005, /* height: context.screenWidth */
                                                                    ),
                                                                    stepperState.steps! ==
                                                                            6
                                                                        ? ElevatedButton(
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Text('Upload'))
                                                                        : Container(),
                                                                    stepperState.steps! <
                                                                            6
                                                                        ? ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              i++;
                                                                              stepperCubit.trackSteps(i);
                                                                            },
                                                                            child: Text(stepperState.steps! == 2
                                                                                ? 'Skip/Next'
                                                                                : 'Next'))
                                                                        : Container()
                                                                  ])
                                                                  .box
                                                                  .width(context
                                                                          .screenWidth *
                                                                      0.95)
                                                                  .make(),
                                                            )
                                                          ],
                                                        )
                                                          .box
                                                          .p12
                                                          .width(context
                                                                  .screenWidth *
                                                              0.95)
                                                          .height(context
                                                                  .screenWidth *
                                                              1.25)
                                                          .make()
                                                      : stepperState.steps! == 3
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                "Please Enter Title For Article"
                                                                    .text
                                                                    .xl
                                                                    .semiBold
                                                                    .make(),
                                                                TextField(
                                                                  controller:
                                                                      titleController,
                                                                  onChanged:
                                                                      (String?
                                                                          data) {
                                                                    title =
                                                                        data;
                                                                  },
                                                                  maxLength:
                                                                      100,
                                                                  //maxLines: 2,
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          "Please Enter Title ",
                                                                      border:
                                                                          OutlineInputBorder()),
                                                                )
                                                                    .box
                                                                    .width(context
                                                                            .screenWidth *
                                                                        0.95)
                                                                    .height(context
                                                                            .screenWidth *
                                                                        0.25)
                                                                    .make(),
                                                                SizedBox(
                                                                  width: context
                                                                      .screenWidth,
                                                                  height: context
                                                                          .screenWidth *
                                                                      0.035,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceAround,
                                                                          children: [
                                                                        stepperState.steps! > 1 &&
                                                                                stepperState.steps! < 6
                                                                            ? ElevatedButton(
                                                                                onPressed: () {
                                                                                  i--;
                                                                                  stepperCubit.trackSteps(i);
                                                                                },
                                                                                child: Text('Back'))
                                                                            : Container(),
                                                                        SizedBox(
                                                                          width:
                                                                              context.screenWidth * 0.005, /* height: context.screenWidth */
                                                                        ),
                                                                        stepperState.steps! ==
                                                                                6
                                                                            ? ElevatedButton(
                                                                                onPressed: () {},
                                                                                child: Text('Upload'))
                                                                            : Container(),
                                                                        stepperState.steps! <
                                                                                5
                                                                            ? ElevatedButton(
                                                                                onPressed: () async {
                                                                                  if (title != null) {
                                                                                    i++;
                                                                                    stepperCubit.trackSteps(i);
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Provide Title For Your Article')));
                                                                                  }
                                                                                },
                                                                                child: Text(stepperState.steps! == 3 ? 'Next' : 'Next'))
                                                                            : Container()
                                                                      ])
                                                                      .box
                                                                      .width(context
                                                                              .screenWidth *
                                                                          0.95)
                                                                      .make(),
                                                                )
                                                              ],
                                                            )
                                                              .box
                                                              .p12
                                                              // .p32
                                                              .width(context
                                                                      .screenWidth *
                                                                  0.95)
                                                              .height(context
                                                                      .screenWidth *
                                                                  1.25)
                                                              .make()
                                                          : stepperState.steps! ==
                                                                  4
                                                              ? Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    "Please Enter Short Description For Article"
                                                                        .text
                                                                        .xl
                                                                        .semiBold
                                                                        .make(),
                                                                    TextField(
                                                                      controller:
                                                                          shortDescController,
                                                                      onChanged:
                                                                          (String?
                                                                              data) {
                                                                        shortDesc =
                                                                            data;
                                                                      },
                                                                      maxLength:
                                                                          100,
                                                                      //maxLines: 2,
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                              "Please Enter Short Description ",
                                                                          border:
                                                                              OutlineInputBorder()),
                                                                    )
                                                                        .box
                                                                        .width(context.screenWidth *
                                                                            0.95)
                                                                        .height(context.screenWidth *
                                                                            0.25)
                                                                        .make(),
                                                                    SizedBox(
                                                                      width: context
                                                                          .screenWidth,
                                                                      height: context
                                                                              .screenWidth *
                                                                          0.035,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment
                                                                                  .spaceAround,
                                                                              children: [
                                                                            stepperState.steps! > 1 && stepperState.steps! < 6
                                                                                ? ElevatedButton(
                                                                                    onPressed: () {
                                                                                      i--;
                                                                                      stepperCubit.trackSteps(i);
                                                                                    },
                                                                                    child: Text('Back'))
                                                                                : Container(),
                                                                            SizedBox(
                                                                              width: context.screenWidth * 0.005, /* height: context.screenWidth */
                                                                            ),
                                                                            stepperState.steps! == 6
                                                                                ? ElevatedButton(onPressed: () {}, child: Text('Upload'))
                                                                                : Container(),
                                                                            stepperState.steps! < 5
                                                                                ? ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      i++;
                                                                                      stepperCubit.trackSteps(i);
                                                                                    },
                                                                                    child: Text(stepperState.steps! == 3 ? 'Skip/Next' : 'Next'))
                                                                                : Container()
                                                                          ])
                                                                          .box
                                                                          .width(context.screenWidth *
                                                                              0.95)
                                                                          .make(),
                                                                    )
                                                                  ],
                                                                )
                                                                  .box
                                                                  .p12
                                                                  // .p32
                                                                  .width(context
                                                                          .screenWidth *
                                                                      0.95)
                                                                  .height(context
                                                                          .screenWidth *
                                                                      1.25)
                                                                  .make()
                                                              : stepperState.steps! ==
                                                                      5
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        "Please Enter Brief Description For Article"
                                                                            .text
                                                                            .xl
                                                                            .semiBold
                                                                            .make(),
                                                                        HtmlEditor(
                                                                          htmlToolbarOptions:
                                                                              HtmlToolbarOptions(
                                                                            customToolbarButtons: [
                                                                              BlocBuilder<AddLinkUrlCubit, AddLinkUrlState>(
                                                                                builder: (context, linkState) {
                                                                                  return linkState.isLinkTapped
                                                                                      ? Container(
                                                                                          //  width: context.screenWidth * 0.95,
                                                                                          height: context.screenWidth * 1.25,
                                                                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                            TextField(
                                                                                              controller: linktext,
                                                                                              decoration: InputDecoration(hintText: 'Enter Clickable Text'),
                                                                                            ).box.width(context.screenWidth * 0.45).height(context.screenWidth * 0.3).make(),
                                                                                            SizedBox(width: context.screenWidth * 0.05),
                                                                                            TextField(
                                                                                              controller: linkUrl,
                                                                                              decoration: InputDecoration(hintText: 'Enter Url here'),
                                                                                            ).box.width(context.screenWidth * 0.45).height(context.screenWidth * 0.3).make(),
                                                                                            SizedBox(width: context.screenWidth * 0.05),
                                                                                            TextButton(
                                                                                                onPressed: () async {
                                                                                                  if (linktext.text.isNotEmpty && linkUrl.text.isNotEmpty) {
                                                                                                    descController.insertLink(linktext.text.trim(), linkUrl.text.trim(), false);
                                                                                                    addLinkCubit.getAddLinkResponse(false);
                                                                                                    linkUrl.clear();
                                                                                                    linktext.clear();
                                                                                                    var d = await descController.getText();
                                                                                                    print('nnn desc  $d ');
                                                                                                  }
                                                                                                },
                                                                                                child: Text('Add Link'))
                                                                                          ]),
                                                                                        )
                                                                                      : IconButton(
                                                                                          onPressed: () {
                                                                                            addLinkCubit.getAddLinkResponse(true);
                                                                                            // addUrl(descController, context, linktext, linkUrl);
                                                                                            //TODO: add link dialog here
                                                                                          },
                                                                                          icon: Icon(Icons.link));
                                                                                },
                                                                              )
                                                                            ],
                                                                            dropdownBackgroundColor:
                                                                                Colors.white,
                                                                            initiallyExpanded:
                                                                                true,
                                                                            defaultToolbarButtons: [
                                                                              StyleButtons(),
                                                                              FontSettingButtons(fontSizeUnit: false),
                                                                              FontButtons(clearAll: false, subscript: false, strikethrough: false, superscript: false),
                                                                              ColorButtons(),
                                                                              ListButtons(listStyles: false),
                                                                              ParagraphButtons(caseConverter: false, textDirection: false),
                                                                              InsertButtons(audio: false, hr: false, link: false, otherFile: false, picture: false, table: false, video: false)
                                                                            ],
                                                                            toolbarPosition:
                                                                                ToolbarPosition.aboveEditor,
                                                                            toolbarType:
                                                                                ToolbarType.nativeScrollable,
                                                                          ),
                                                                          controller:
                                                                              descController, //required
                                                                          otherOptions:
                                                                              OtherOptions(height: context.screenWidth * 0.5),
                                                                          htmlEditorOptions:
                                                                              HtmlEditorOptions(
                                                                            initialText: widget.IsEditArticle
                                                                                ? widget.articleData.articleDescription
                                                                                : null,
                                                                            adjustHeightForKeyboard:
                                                                                false,
                                                                            autoAdjustHeight:
                                                                                false,
                                                                            hint:
                                                                                "Please Enter Description Here...",
                                                                          ),
                                                                        )
                                                                            .box
                                                                            .width(context.screenWidth *
                                                                                0.95)
                                                                            .height(context.screenWidth *
                                                                                0.75)
                                                                            .make(),
                                                                        SizedBox(
                                                                          width:
                                                                              context.screenWidth,
                                                                          height:
                                                                              context.screenWidth * 0.005,
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          child:
                                                                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                            stepperState.steps! > 1 && stepperState.steps! < 6
                                                                                ? ElevatedButton(
                                                                                    onPressed: () {
                                                                                      i--;
                                                                                      stepperCubit.trackSteps(i);
                                                                                    },
                                                                                    child: Text('Back'))
                                                                                : Container(),
                                                                            SizedBox(
                                                                              width: context.screenWidth * 0.005,
                                                                            ),
                                                                            stepperState.steps! == 6
                                                                                ? ElevatedButton(onPressed: () {}, child: Text('Upload'))
                                                                                : Container(),
                                                                            stepperState.steps! < 6
                                                                                ? ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      desciption = await descController.getText();
                                                                                      print('see The Description $desciption');
                                                                                      if (desciption != "") {
                                                                                        print('NNNN DESCRIPTION ');
                                                                                        i++;
                                                                                        stepperCubit.trackSteps(i);
                                                                                      } else {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                          content: Text('Please Provide Description to Your Article And Length More Than 210'),
                                                                                        ));
                                                                                      }
                                                                                    },
                                                                                    child: Text(stepperState.steps! == 3 ? 'Skip/Next' : 'Next'))
                                                                                : Container()
                                                                          ]).box.width(context.screenWidth * 0.95).make(),
                                                                        )
                                                                      ],
                                                                    )
                                                                      .box
                                                                      .p12
                                                                      // .p8
                                                                      .width(context.screenWidth *
                                                                          0.95)
                                                                      .height(
                                                                          context.screenWidth * 1.25)
                                                                      .make()
                                                                  : stepperState.steps! == 6
                                                                      ? Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            "Preview Of Article"
                                                                                .text
                                                                                .xl
                                                                                .semiBold
                                                                                .make()
                                                                                .box
                                                                                //.px24
                                                                                .alignCenterLeft
                                                                                .make(),
                                                                            /*  SizedBox(
                                                                            height:
                                                                                context.screenWidth * 0.015), */
                                                                            Column(
                                                                              children: [
                                                                                photoString != 'WithoutImage' ? Image.network(photoString!).box.width(context.screenWidth * 0.75).height(context.screenWidth * 0.4).make() : Container(),
                                                                                SizedBox(width: context.screenWidth, height: context.screenWidth * 0.005),
                                                                                title!.text.bold.xl3.make().box.alignCenterLeft.make(),
                                                                                SizedBox(width: context.screenWidth, height: context.screenWidth * 0.005),
                                                                                Html(
                                                                                    onLinkTap: (url, _, __, ___) {
                                                                                      print("Opening $url...");
                                                                                      if (url != null) {
                                                                                        if (url.split("https://").length == 1) {
                                                                                          launch("https://$url");
                                                                                        } else {
                                                                                          launch(url);
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    data: desciption),
                                                                                "Author - $authorName".text.bold.xl.make().box.alignCenterLeft.make()
                                                                              ],
                                                                            ).scrollVertical().box.width(context.screenWidth * 0.95).height(context.screenWidth * 1.25).make(),
                                                                            Align(
                                                                                alignment: Alignment.bottomRight,
                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                  /*  stepperState.steps! > 1 && stepperState.steps! <= 6
                                                                                ? ElevatedButton(
                                                                                    onPressed: () {
                                                                                      i--;
                                                                                      stepperCubit.trackSteps(i);
                                                                                    },
                                                                                    child: Text('Back'))
                                                                                : Container(),
                                                                            SizedBox(
                                                                              width: context.screenWidth * 0.005, /* height: context.screenWidth */
                                                                            ), */
                                                                                  stepperState.steps! == 6
                                                                                      ? ElevatedButton(
                                                                                          onPressed: () {
                                                                                            ArticleCreationModel model = ArticleCreationModel(articleDescription: desciption, articleLike: [], articlePhotoUrl: photoString, articleReportedBy: [], articleSubtype: subTypeName, authorName: authorName, authorUid: authorUid, bookmarkedBy: [], country: ['All'], createdTime: FieldValue.serverTimestamp(), galleryImages: [], isArticlePublished: 'NotPublished', isArticleReported: 'NotReported', moderator: '', noOfComments: 0, documentId: documentId, noOfLikes: 0, noOfViews: 0, postedTime: FieldValue.serverTimestamp(), sentNotificationForPublished: 'False', socialMediaLink: 'https://www.journz.in/?Page=/Articles&id=$documentId', articleTitle: titleController.text.trim(), shortDesc: shortDescController.text.isEmptyOrNull ? "Short Description" : shortDescController.text);
                                                                                            FirebaseFirestore.instance.collection('NewArticleCollection').doc(documentId).set(model.toJson()).then((value) => context.vxNav.pop());
                                                                                          },
                                                                                          child: Text('Upload'))
                                                                                      : Container(),
                                                                                  /*   stepperState.steps! < 6
                                                                                ? ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      if (title != null) {
                                                                                        i++;
                                                                                        stepperCubit.trackSteps(i);
                                                                                      } else {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Provide Title For Your Article')));
                                                                                      }
                                                                                    },
                                                                                    child: Text(stepperState.steps! == 2 ? 'Skip/Next' : 'Next'))
                                                                                : Container() */
                                                                                ]) //.box.width(context.screenWidth * 1.5).make(),
                                                                                )
                                                                          ],
                                                                        )
                                                                          .box
                                                                          .p12
                                                                          //  .p8
                                                                          .width(context.screenWidth * 0.95)
                                                                          .height(context.screenWidth * 1.55)
                                                                          .make()
                                                                      : Container(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  /*  BodyRightPane(
                                    isHome: false,
                                    favouriteCategory: swapToFavouriteArticles,
                                  ) */
                                ],
                              )
                                  .box
                                  .width(context.screenWidth)
                                  .height(context.screenWidth * 2)
                                  .make(),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator())
            : Center(child: CircularProgressIndicator());
      },
    ));
  }

  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }

  addUrl(HtmlEditorController controller, BuildContext context,
      TextEditingController lText, TextEditingController uText) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: [
            Column(
              children: [
                Container(
                  width: context.screenWidth * 0.2,
                  height: context.screenWidth * 0.15,
                  child: Column(
                    children: [
                      TextField(
                        controller: lText,
                        decoration:
                            InputDecoration(hintText: 'Enter Clickable Text'),
                      ),
                      SizedBox(height: context.screenWidth * 0.05),
                      TextField(
                        controller: uText,
                        onChanged: (value) {
                          print('nnnn ${lText.selection}');
                        },
                        decoration: InputDecoration(hintText: 'Enter Url here'),
                      ),
                      SizedBox(height: context.screenWidth * 0.05),
                      ElevatedButton(
                          onPressed: () {
                            if (lText.text.isNotEmpty &&
                                uText.text.isNotEmpty) {
                              controller.insertLink(
                                  lText.text.trim(), uText.text.trim(), false);
                            }
                          },
                          child: Text('Add :Link'))
                    ],
                  ),
                ),
                SizedBox(height: context.screenWidth * 0.3),
              ],
            ),
          ]);
        });
  }
}
