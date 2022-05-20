/* import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:content_moderator/Add_Articles/cubits/AddPhotoToArticle/addphototoarticle_cubit.dart';
import 'package:content_moderator/Add_Articles/cubits/render_selected_subtype_name_cubit/render_selected_subtype_name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

class AddArticlesScreen extends StatefulWidget {
  Map<String, dynamic>? parameters;
  AddArticlesScreen({Key? key, this.parameters}) : super(key: key);

  @override
  _AddArticlesScreenState createState() => _AddArticlesScreenState();
}

class _AddArticlesScreenState extends State<AddArticlesScreen>
    with WidgetsBindingObserver {
  HtmlEditorController htmlController = HtmlEditorController();
  HtmlEditorController htmlController2 = HtmlEditorController();
  List<String> subItems = [];

  var v;
  @override
  void didChangeDependencies() {
    subItems = List.from(widget.parameters!['Subtype']);
    if (widget.parameters != null) {
      if (widget.parameters!['Subtype'] == []) {
        context.vxNav.popToRoot();
      }
    } else {
      context.vxNav.popToRoot();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final addPhotoCubit = BlocProvider.of<AddphotoarticleCubit>(context);
    final subTypenameRenderCubit =
        BlocProvider.of<RenderSelectedSubtypeNameCubit>(context);

    return WillPopScope(
      onWillPop: () {
        print('nnn back pressed');
        return Future.value(false);
      },
      child: Scaffold(
          body: SizedBox(
        width: context.screenWidth,
        child: Row(
          children: [
            // left Side Empty Space
            Container(
              color: Colors.white,
              height: context.screenHeight,
              width: context.screenWidth * 0.1,
            ),
            Container(
              color: Colors.grey[300],
              height: context.screenHeight,
              width: context.screenWidth * 0.8,
              padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.02,
                  vertical: context.screenHeight * 0.015),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      elevation: 5,
                      child: "Article Creation"
                          .text
                          .xl2
                          .bold
                          .make()
                          .box
                          .px12
                          .width(context.screenWidth)
                          .height(context.screenHeight * 0.07)
                          // .neumorphic(color: Colors.white)
                          .alignCenterLeft
                          .make()),
                  SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.035,
                  ),
                  /*    BlocBuilder<AddphotoarticleCubit, AddphotoarticleState>(
                    builder: (context, addPhotoState) {
                      return InkWell(
                        onTap: () {
                          addPhotoCubit.uploadToStorage('nick');
                        },
                        child: Container(
                          width: context.screenWidth * 0.25,
                          height: context.screenHeight * 0.3,
                          decoration: BoxDecoration(
                              image: !addPhotoState.isPhotoUploaded!
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/add_photo.png'))
                                  : DecorationImage(
                                      image: NetworkImage(
                                          addPhotoState.photoURL!))),
                        ),
                      );
                    },
                  )
                      .box
                      .width(context.screenWidth * 0.3)
                      .height(context.screenHeight * 0.4)
                      .makeCentered(),
                  SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.035,
                  ),
                */
                  BlocBuilder<RenderSelectedSubtypeNameCubit,
                          RenderSelectedSubtypeNameState>(
                    builder: (context, subtypeState) {
                      return DropdownButton<String>(
                          dropdownColor: Colors.grey[200],
                          isExpanded: true,
                          hint: Text('Select A Subtype'),
                          value: subtypeState.selectedSubtype,
                          onChanged: (String? value) {
                            subTypenameRenderCubit.getSelectedSubtype(value);
                            /*  subtypeForFolder = value!;
                                                        selectedSubType = value;
                                                        articlesubtypeCubit
                                                            .getNoOfArticleUnderCategory(value);
                                                        setState(() {});
                                                        print('nnn val '); */
                          },
                          items: subItems
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList());
                    },
                  )
                      .box
                      .alignCenterLeft
                      .width(context.screenWidth * 0.35)
                      .height(context.screenHeight * 0.05)
                      .make(),
                  SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.035,
                  ),
                  HtmlEditor(
                    htmlToolbarOptions: HtmlToolbarOptions(
                      dropdownBackgroundColor: Colors.white,
                      initiallyExpanded: true,
                      defaultToolbarButtons: [
                        StyleButtons(),
                        FontSettingButtons(fontSizeUnit: false),
                        FontButtons(
                            clearAll: false,
                            subscript: false,
                            strikethrough: false,
                            superscript: false),
                        ColorButtons(),
                        ListButtons(listStyles: false),
                        ParagraphButtons(
                            caseConverter: false, textDirection: false),
                        InsertButtons(
                            audio: false,
                            hr: false,
                            link: true,
                            otherFile: false,
                            picture: false,
                            table: false,
                            video: false)
                      ],
                      toolbarPosition: ToolbarPosition.aboveEditor,
                      toolbarType: ToolbarType.nativeGrid,
                    ),
                    controller: htmlController, //required
                    htmlEditorOptions: HtmlEditorOptions(
                      adjustHeightForKeyboard: false,
                      autoAdjustHeight: false,
                      hint: "Your text here...",
                      //initalText: "text content initial, if any",
                    ),
                  )
                      .box
                      .width(context.screenWidth)
                      .height(context.screenHeight * 0.65)
                      .make(),
                  SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.035,
                  ),
                  /* ElevatedButton(
                      onPressed: () async {
                        v = await htmlController.getText();
                        print('nnn data $v');
                        htmlController2.setText(v);
                        setState(() {});
                      },
                      child: Text('try')), */
                  SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.035,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        v = await htmlController.getText();
                        print('nnn data $v');
                        FirebaseFirestore.instance
                            .collection('NewArticleCollectionCheck')
                            .doc()
                            .set({'ArticleDetails': v});
                      },
                      child: Text('Create'))
                  /*  Html(
                    data: v ?? 'dd',
                    onLinkTap: (url, _, __, ___) {
                      launch(url.toString());
                    },
                  )
                      .box
                      .width(context.screenWidth)
                      .height(context.screenHeight * 0.7)
                      .make(), */
                ],
              ).scrollVertical(),
            ),
            // Right Side Empty Space
            Container(
              color: Colors.white,
              height: context.screenHeight,
              width: context.screenWidth * 0.1,
            )
          ],
        ),
      )),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('nnn State $state');
        break;
      case AppLifecycleState.inactive:
        print('nnn State $state');
        break;
      case AppLifecycleState.paused:
        print('nnn State $state');
        break;
      case AppLifecycleState.detached:
        print('nnn State $state');
        break;
    }
  }
}
 */