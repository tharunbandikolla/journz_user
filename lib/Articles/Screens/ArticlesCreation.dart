import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/scheduler.dart';
import '/Articles/ArticlesBloc/GalleryPhotoCubit/galleryphoto_cubit.dart';
import '/Articles/ArticlesBloc/GetGalleryFileCubit/getgalleryfile_cubit.dart';
import '/Articles/ArticlesBloc/UploadGalleryImage/uploadgalleryimg_cubit.dart';
import '/Articles/DataModel/GalleryFileModel.dart';
import '/Articles/Screens/GetGalleryImageScreen.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import 'package:velocity_x/velocity_x.dart';
import '/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/Articles/ArticlesBloc/ArticlesSubtypeCubit/articlesubtype_cubit.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/Articles/DataServices/ArticlesDatabase.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Widgets/ButtonForApp.dart';
import '/Common/Widgets/TextFieldHeader.dart';
import '/HomeScreen/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class ArticlesCreation extends StatefulWidget {
  ArticlesModel? model;
  bool fromEdit;
  ArticlesCreation({Key? key, required this.fromEdit, this.model})
      : super(key: key);

  @override
  _ArticlesCreationState createState() => _ArticlesCreationState();
}

class _ArticlesCreationState extends State<ArticlesCreation> {
  GlobalKey<FormState> _createArticleFormKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? subtypeForFolder;
  String? title, desc;
  List<String> articleSearchTag = [];
  String? selectedSubType;
  String? authorName, authorUid, articlePhotoURL;
  int? noOfArticlesUnderCategory;
  bool checkAddPhotoBeforeUpload = false;
  bool checkAddPhotoAfterUpload = false;
  String? documentId;
  File? photoFile;
  String? photoString;
  String? photoStringFromEdit;
  List<GalleryFileModel> galleryFiles = [];
  List<Map<String, dynamic>> galleryString = [];
  int? noOfArticles;
  bool checked = false;
  var socialLink;
  setInitialDataFromEdit() {
    if (widget.fromEdit) {
      if (widget.model != null) {
        selectedSubType = widget.model!.articleSubType!;
        subtypeForFolder = widget.model!.articleSubType!;
        photoStringFromEdit = widget.model!.photoUrl!;
        checkAddPhotoAfterUpload =
            widget.model!.hasImage! == "Yes" ? true : false;
        _titleController.text = widget.model!.articletitle!;
        _descriptionController.text = widget.model!.articledesc!;
        documentId = widget.model!.documentId!;
        print('docid ${widget.model!.documentId!}');
        print('docid photo $photoString');
      }
    }
  }

  @override
  void initState() {
    if (widget.fromEdit) {
      setInitialDataFromEdit();
    }
    if (!widget.fromEdit) {
      documentId = randomAlphaNumeric(25);
      print('nnn doc id $documentId');
    }
    context.read<ArticlesubtypeCubit>().getArticleSubTypeFromDB();
    context.read<ArticlesubtypeCubit>().getAuthorNameFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addPhotoCubit = BlocProvider.of<AddphotoarticleCubit>(context);
    final loadingCubit = BlocProvider.of<LoadingscreenCubit>(context);
    final checkBoxCubit = BlocProvider.of<SignupcheckboxCubit>(context);
    final articlesubtypeCubit = BlocProvider.of<ArticlesubtypeCubit>(context);
    final galleryCubit = BlocProvider.of<GalleryphotoCubit>(context);
    final uploadGalleryCubit = BlocProvider.of<UploadgalleryimgCubit>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 12,
          /*leading: IconButton(
              icon: Image.asset('images/fluenzologo.png'), onPressed: () {}),*/
          title: Text(
            appName,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<LoadingscreenCubit, LoadingscreenState>(
          builder: (context, state) {
            return state.isNotLoading
                ? SingleChildScrollView(
                    child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.05,
                        vertical: getWidth(context) * 0.01),
                    width: getWidth(context),
                    // height: getHeight(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: getWidth(context) * 0.02),
                        Container(
                          width: getWidth(context),
                          child: BlocBuilder<AddphotoarticleCubit,
                              AddphotoarticleState>(builder: (context, state) {
                            photoFile = state.articlePhotoFile;
                            photoString = state.photoURL;
                            state.isPhotoUploaded!
                                ? checkAddPhotoAfterUpload = true
                                : checkAddPhotoAfterUpload = false;

                            print('nnn  checkAddPhotoAfterUpload  ');

                            print(
                                'nnn builder ${state.articlePhotoFile}  ${state.photoURL}  ${state.isPhotoUploaded}');
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                state.articlePhotoFile == null
                                    ? Container(
                                        width: getWidth(context) * 0.65,
                                        height: getWidth(context) * 0.55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                getWidth(context) * 0.05),
                                            color: Colors.amber,
                                            shape: BoxShape.rectangle,
                                            image: widget.fromEdit
                                                ? widget.model!.hasImage! ==
                                                        "Yes"
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            widget.model!
                                                                .photoUrl!),
                                                        fit: BoxFit.fill)
                                                    : DecorationImage(
                                                        image: AssetImage(
                                                            'images/contentWriter.png'),
                                                        fit: BoxFit.fill)
                                                : DecorationImage(
                                                    image: AssetImage(
                                                        'images/contentWriter.png'),
                                                    fit: BoxFit.fill)),
                                      )
                                    : Container(
                                        width: getWidth(context) * 0.65,
                                        height: getWidth(context) * 0.55,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                                image: FileImage(photoFile!),
                                                fit: BoxFit.fill)),
                                      ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: BlocBuilder<ThemebasedwidgetCubit,
                                      ThemebasedwidgetState>(
                                    builder: (context, tState) {
                                      return IconButton(
                                          onPressed: () {
                                            if (subtypeForFolder == null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return tState.isLightTheme
                                                        ? ShowAlertNewDarkDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Please Select Category')
                                                        : ShowAlertNewLightDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Please Select Category');
                                                  });
                                            } else {
                                              if (state.isPhotoUploaded!) {
                                                print('nnn p remove');
                                                addPhotoCubit
                                                    .closeSelectedPhoto();
                                                photoFile = null;
                                                photoString = null;

                                                checkAddPhotoBeforeUpload =
                                                    false;
                                                checkAddPhotoAfterUpload =
                                                    false;
                                                //setState(() {});
                                              } else {
                                                print('nnn p add');
                                                addPhotoCubit.getPhoto(
                                                    subtypeForFolder!,
                                                    ctx: context);
                                                print(
                                                    'nnn bool brfore Pressed ');
                                                checkAddPhotoBeforeUpload =
                                                    true;
                                                print(
                                                    'nnn bool After Pressed ');
                                              }
                                            }
                                          },
                                          icon: Icon(
                                              state.isPhotoUploaded!
                                                  ? Icons.close
                                                  : Icons.add_a_photo,
                                              size: 30));
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        SizedBox(height: getWidth(context) * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textFieldHeader(context, 'Select Category *'),
                            BlocBuilder<ArticlesubtypeCubit,
                                ArticlesubtypeState>(
                              builder: (context, state) {
                                this.authorName = state.authorName;
                                this.authorUid = state.authorUid;
                                this.noOfArticles =
                                    state.noOfArticlesPostedByAuthor;
                                print(
                                    'nnn no ${state.noOfArticlesUnderCategory}');
                                this.noOfArticlesUnderCategory =
                                    state.noOfArticlesUnderCategory;
                                return DropdownButton<String>(
                                    hint: Text('Select A Subtype'),
                                    value: selectedSubType,
                                    onChanged: (String? value) {
                                      subtypeForFolder = value!;
                                      selectedSubType = value;
                                      articlesubtypeCubit
                                          .getNoOfArticleUnderCategory(value);
                                      setState(() {});
                                      print('nnn val ');
                                    },
                                    items: state.subtype!
                                        .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                        .toList());
                              },
                            )
                          ],
                        ),
                        Column(children: [
                          Form(
                              key: _createArticleFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  textFieldHeader(context, 'Title *'),
                                  SizedBox(height: getWidth(context) * 0.015),
                                  TextFormField(
                                    controller: _titleController,
                                    style: TextStyle(
                                        fontSize: getWidth(context) * 0.055),
                                    maxLines: 3,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Field must not be Empty';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: getWidth(context) * 0.05,
                                            left: getWidth(context) * 0.05),
                                        hintText: 'Title',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                getWidth(context) * 0.055),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                getWidth(context) * 0.1))),
                                  ),
                                  SizedBox(height: getWidth(context) * 0.02),
                                  textFieldHeader(context, 'Description *'),
                                  SizedBox(height: getWidth(context) * 0.015),
                                  TextFormField(
                                    controller: _descriptionController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Field must not be Empty';
                                      }
                                    },
                                    style: TextStyle(
                                        fontSize: getWidth(context) * 0.055),
                                    maxLines: 25,
                                    onChanged: (val) {
                                      desc = val;
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: getWidth(context) * 0.05,
                                            left: getWidth(context) * 0.05),
                                        hintText: 'Description',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                getWidth(context) * 0.055),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                getWidth(context) * 0.08))),
                                  ),
                                  SizedBox(height: getWidth(context) * 0.1),
                                  /*textFieldHeader(context, 'Tags'),
                                  SizedBox(height: getWidth(context) * 0.015),
                                  BlocBuilder<SearchTagCubit, SearchTagState>(
                                      builder: (context, state) {
                                    //articleSearchTag = state.category!;
                                    return Column(children: [
                                      TextFormField(
                                        controller: _tagsController,
                                        style: TextStyle(
                                            fontSize:
                                                getWidth(context) * 0.055),
                                        //maxLines: 3,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                if (_tagsController.text !=
                                                    '') {
                                                  articleCubit
                                                      .addDataToCategoryList(
                                                          _tagsController.text);
                                                  this.articleSearchTag.add(
                                                      _tagsController.text);

                                                  _tagsController.clear();
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: getWidth(context) * 0.05),
                                            hintText: 'Tags',
                                            hintStyle: TextStyle(
                                                fontSize: getWidth(context) *
                                                    0.055),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getWidth(context) *
                                                            0.08))),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  getWidth(context) * 0.02),
                                          constraints: BoxConstraints(
                                              maxHeight:
                                                  getWidth(context) * 0.3),
                                          child: GridView.builder(
                                              itemCount: state.category!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 2.5,
                                                      crossAxisCount: 3),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          getWidth(context) *
                                                              0.02),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          state
                                                              .category![index],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            articleCubit
                                                                .removeDataFromCategoryList(
                                                                    state.category![
                                                                        index]);
                                                          },
                                                          icon:
                                                              Icon(Icons.close))
                                                    ],
                                                  ),
                                                );
                                              }))
                                    ]);
                                  }),
                                  SizedBox(
                                    height: getWidth(context) * 0.05,
                                  ),*/
                                  /*InkWell(
                                  onTap: () {
                                    final df = DateFormat('dd-MM-yyyy hh:mm a');
                                    print(
                                        'nnn upload  ${df.format(DateTime.now()).toString()} ${_descriptionController.text} \n ${this.articleSearchTag}');
                                    ArticlesModel model = ArticlesModel(
                                        authorName: this.authorName!,
                                        authorUid: this.authorUid!,
                                        articleSubType: selectedSubType!,
                                        articletitle: _titleController.text,
                                        articledesc: _descriptionController.text,
                                        isArticlePublished: 'NotPublished',
                                        isArticleReported: 'NotRepored',
                                        searchKey: this.articleSearchTag,
                                        createdTime:
                                            df.format(DateTime.now()).toString(),
                                        updatedTime:
                                            df.format(DateTime.now()).toString());
        
                                    ArticlesDataBase()
                                        .addArticleToDB(model.toJson())
                                        .then(() {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen()),
                                          (route) => false);
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  getWidth(context) * 0.08))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getWidth(context) * 0.015,
                                            horizontal: getWidth(context) * 0.07),
                                        child: Text(
                                          'Create Article',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: getWidth(context) * 0.05),
                                        ),
                                      )),
                                ),*/

                                  BlocBuilder<SignupcheckboxCubit,
                                      SignupcheckboxState>(
                                    builder: (context, state) {
                                      checked = state.check;
                                      return Column(
                                        children: [
                                          CheckboxListTile(
                                            title: Text(
                                                "Are You Wish to Add Photos To Gallery.?"),
                                            value: state.check,
                                            onChanged: (newValue) {
                                              print('nnn checked ');
                                              checkBoxCubit
                                                  .checkToggle(newValue);
                                              //setState(() {});
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          ),
                                          state.check
                                              ? BlocBuilder<GalleryphotoCubit,
                                                  GalleryphotoState>(
                                                  builder: (context, gState) {
                                                    gState.photo != null
                                                        ? galleryFiles =
                                                            gState.photo!
                                                        : galleryFiles = [];

                                                    print(
                                                        'nnnn gallery $galleryFiles');
                                                    return Container(
                                                      height:
                                                          context.screenWidth *
                                                              1.25,
                                                      //color: Colors.],
                                                      width:
                                                          context.screenWidth,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            height: context
                                                                .screenWidth,
                                                            width: context
                                                                .screenWidth,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        400]!,
                                                                    width: 1)),
                                                            child: Column(
                                                              children: [
                                                                "You Can Add Min 3 And Max !0 Images"
                                                                    .text
                                                                    .semiBold
                                                                    .lg
                                                                    .make()
                                                                    .box
                                                                    .p8
                                                                    .make(),
                                                                5.heightBox,
                                                                GridView
                                                                    .builder(
                                                                        physics:
                                                                            PageScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount:
                                                                            galleryFiles.length +
                                                                                1,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                3),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return index == 0
                                                                              ? Center(
                                                                                  child: BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
                                                                                    builder: (context, tState) {
                                                                                      return IconButton(
                                                                                        onPressed: () async {
                                                                                          if (galleryFiles.length <= 10) {
                                                                                            Map<String, dynamic> imageFileData = await Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => BlocProvider(
                                                                                                          create: (context) => GetgalleryfileCubit(),
                                                                                                          child: GetGalleryImage(),
                                                                                                        )));
                                                                                            print('nnn imageFileData ');
                                                                                            galleryCubit.getImageForGallery(imageFileData, galleryFiles);
                                                                                          } else {
                                                                                            showDialog(
                                                                                                context: context,
                                                                                                builder: (context) {
                                                                                                  return tState.isLightTheme ? ShowAlertNewDarkDialogBox(alertType: 'Alert..!', alertMessage: 'max Limit 10 Images') : ShowAlertNewLightDialogBox(alertType: 'Alert..!', alertMessage: 'MAx Linit 10 Images');
                                                                                                });
                                                                                          }
                                                                                        },
                                                                                        icon: Icon(Icons.add),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              : Stack(children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.all(5),
                                                                                    decoration: BoxDecoration(image: DecorationImage(image: FileImage(galleryFiles[index - 1].file!), fit: BoxFit.fill)),
                                                                                  ),
                                                                                  Positioned(
                                                                                    right: 0.1,
                                                                                    top: 0.1,
                                                                                    child: IconButton(
                                                                                        onPressed: () {
                                                                                          galleryCubit.removeImage(galleryFiles, index - 1);
                                                                                        },
                                                                                        icon: Icon(
                                                                                          Icons.remove_circle_outline_sharp,
                                                                                          color: Colors.black,
                                                                                        )),
                                                                                  ),
                                                                                ]);
                                                                        }),
                                                              ],
                                                            ),
                                                          ),
                                                          BlocBuilder<
                                                              UploadgalleryimgCubit,
                                                              UploadgalleryimgState>(
                                                            builder: (context,
                                                                iState) {
                                                              iState.galleryString !=
                                                                      null
                                                                  ? galleryString =
                                                                      iState
                                                                          .galleryString!
                                                                  : galleryString =
                                                                      [];

                                                              print(
                                                                  'nnnnn ga uploades $galleryString');
                                                              return AppButton(
                                                                ctx:
                                                                    scaffoldKey,
                                                                title: iState
                                                                        .uploadTapped!
                                                                    ? galleryFiles.length ==
                                                                            galleryString.length
                                                                        ? 'Uploaded'
                                                                        : 'Please Wait'
                                                                    : 'Upload',
                                                                func: () async {
                                                                  if (galleryFiles !=
                                                                          [] &&
                                                                      documentId !=
                                                                          null) {
                                                                    for (GalleryFileModel i
                                                                        in galleryFiles) {
                                                                      uploadGalleryCubit.uploadGalleryImage(
                                                                          tap:
                                                                              true,
                                                                          file:
                                                                              i,
                                                                          imgUrl:
                                                                              galleryString,
                                                                          bucket:
                                                                              documentId!);
                                                                    }
                                                                  }
                                                                },
                                                              );
                                                            },
                                                          ),
                                                          5.heightBox,
                                                          "Please Wait Until The Button changes To Uploaded"
                                                              .text
                                                              .center
                                                              .make()
                                                              .box
                                                              .px16
                                                              .width(context
                                                                  .screenWidth)
                                                              .height(context
                                                                      .screenWidth *
                                                                  0.1)
                                                              .makeCentered()
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                        ],
                                      );
                                    },
                                  ),
                                  15.heightBox,
                                  BlocBuilder<ThemebasedwidgetCubit,
                                      ThemebasedwidgetState>(
                                    builder: (context, tState) {
                                      return Container(
                                        width: getWidth(context),
                                        alignment: Alignment.center,
                                        child: AppButton(
                                          ctx: scaffoldKey,
                                          title: widget.fromEdit
                                              ? 'Update Article'
                                              : 'Create Article',
                                          func: () async {
                                            final df = DateFormat(
                                                'dd-MM-yyyy hh:mm a');
                                            // print(
                                            //   'nnn upload \n ${df.format(DateTime.now()).toString()} ${_descriptionController.text} \n ${this.articleSearchTag}');
                                            if (_createArticleFormKey
                                                .currentState!
                                                .validate()) {
                                              socialLink = await generateLink();
                                              _createArticleFormKey
                                                  .currentState!
                                                  .save();
                                              if (subtypeForFolder != null) {
                                                print(
                                                    'nnn cond   $photoString $photoStringFromEdit ');
                                                if ((widget.fromEdit
                                                        ? photoString == null
                                                        //'WithoutImage'
                                                        : photoString ==
                                                            null) &&
                                                    (widget.fromEdit
                                                        ? photoStringFromEdit ==
                                                            'WithoutImage'
                                                        : photoStringFromEdit ==
                                                            null)) {
                                                  if (checked) {
                                                    if (galleryString.length >=
                                                        3) {
                                                      print(
                                                          'nnn without Photo');
                                                      print('nnn executed');
                                                      loadingCubit
                                                          .changeLoadingState(
                                                              false);

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'ArticleSubtype')
                                                          .where('SubType',
                                                              isEqualTo:
                                                                  selectedSubType)
                                                          .get()
                                                          .then((value) async {
                                                        if (value.size != 0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'ArticleSubtype')
                                                              .doc(value.docs
                                                                  .first.id)
                                                              .update({
                                                            'NoOfArticles':
                                                                noOfArticlesUnderCategory! +
                                                                    1
                                                          });
                                                        }
                                                      });
                                                      print(
                                                          'nnn social link $socialLink');
                                                      ArticlesModel model =
                                                          ArticlesModel(
                                                              socialMediaLink:
                                                                  socialLink,
                                                              sentNotificatonForPublished:
                                                                  "False",
                                                              authorName: this
                                                                  .authorName!,
                                                              photoUrl:
                                                                  'WithoutImage',
                                                              authorUid: this
                                                                  .authorUid!,
                                                              articleSubType:
                                                                  selectedSubType!,
                                                              articletitle:
                                                                  _titleController
                                                                      .text,
                                                              articledesc:
                                                                  _descriptionController
                                                                      .text,
                                                              hasImage: 'No',
                                                              noOfLike: '0',
                                                              noOfComment: '0',
                                                              //fieldValue: FieldValue
                                                              //  .serverTimestamp(),
                                                              peopleLike: [],
                                                              isArticlePublished:
                                                                  'NotPublished',
                                                              isArticleReported:
                                                                  'NotReported',
                                                              documentId:
                                                                  documentId,
                                                              // searchKey:
                                                              //   this.articleSearchTag,
                                                              createdTimeFieldValue:
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                              updatedTimeFieldValue:
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                              noOfViews: 0,
                                                              bookMarkedPeoples: [],
                                                              galleryImages:
                                                                  galleryString,
                                                              reportedPeoples: []);

                                                      widget.fromEdit
                                                          ? ArticlesDataBase()
                                                              .updateArticleInDB(
                                                                  documentId!,
                                                                  model
                                                                      .toJson())
                                                          : ArticlesDataBase()
                                                              .addArticleToDB(
                                                                  documentId!,
                                                                  model
                                                                      .toJson())
                                                              .whenComplete(() {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'UserProfile')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .update({
                                                                'NoOfArticlesPosted':
                                                                    noOfArticles! +
                                                                        1
                                                              });
                                                            });
/* 
                                                      SchedulerBinding.instance!
                                                          .addPostFrameCallback(
                                                              (_) { */

                                                      Navigator
                                                          .pushReplacementNamed(
                                                        context,
                                                        '/Home',
                                                      );

                                                      //});
                                                    } else {
                                                      galleryFiles = [];
                                                      galleryString = [];
                                                      galleryCubit
                                                          .getImageForGallery(
                                                              null, null);
                                                      context
                                                          .read<
                                                              UploadgalleryimgCubit>()
                                                          .uploadGalleryImage(
                                                              tap: false);

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return tState
                                                                    .isLightTheme
                                                                ? ShowAlertNewDarkDialogBox(
                                                                    alertType:
                                                                        'Alert..!',
                                                                    alertMessage:
                                                                        'Minimum 3 Gallery Images Required')
                                                                : ShowAlertNewLightDialogBox(
                                                                    alertType:
                                                                        'Alert..!',
                                                                    alertMessage:
                                                                        'Minimum 3 Gallery Images Required');
                                                          });
                                                    }
                                                  } else {
                                                    print('nnn without Photo');
                                                    print('nnn executed');
                                                    loadingCubit
                                                        .changeLoadingState(
                                                            false);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'ArticleSubtype')
                                                        .where('SubType',
                                                            isEqualTo:
                                                                selectedSubType)
                                                        .get()
                                                        .then((value) async {
                                                      if (value.size != 0) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ArticleSubtype')
                                                            .doc(value
                                                                .docs.first.id)
                                                            .update({
                                                          'NoOfArticles':
                                                              noOfArticlesUnderCategory! +
                                                                  1
                                                        });
                                                      }
                                                    });
                                                    ArticlesModel model =
                                                        ArticlesModel(
                                                            socialMediaLink:
                                                                socialLink,
                                                            sentNotificatonForPublished:
                                                                "False",
                                                            authorName: this
                                                                .authorName!,
                                                            photoUrl:
                                                                'WithoutImage',
                                                            authorUid:
                                                                this.authorUid!,
                                                            articleSubType:
                                                                selectedSubType!,
                                                            articletitle:
                                                                _titleController
                                                                    .text,
                                                            articledesc:
                                                                _descriptionController
                                                                    .text,
                                                            hasImage: 'No',
                                                            noOfLike: '0',
                                                            noOfComment: '0',
                                                            //fieldValue: FieldValue
                                                            //  .serverTimestamp(),
                                                            peopleLike: [],
                                                            isArticlePublished:
                                                                'NotPublished',
                                                            isArticleReported:
                                                                'NotReported',
                                                            documentId:
                                                                documentId,
                                                            // searchKey:
                                                            //   this.articleSearchTag,
                                                            createdTimeFieldValue:
                                                                FieldValue
                                                                    .serverTimestamp(),
                                                            updatedTimeFieldValue:
                                                                FieldValue
                                                                    .serverTimestamp(),
                                                            noOfViews: 0,
                                                            bookMarkedPeoples: [],
                                                            galleryImages:
                                                                galleryString,
                                                            reportedPeoples: []);

                                                    widget.fromEdit
                                                        ? ArticlesDataBase()
                                                            .updateArticleInDB(
                                                                documentId!,
                                                                model.toJson())
                                                        : ArticlesDataBase()
                                                            .addArticleToDB(
                                                                documentId!,
                                                                model.toJson())
                                                            .whenComplete(() {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'UserProfile')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .update({
                                                              'NoOfArticlesPosted':
                                                                  noOfArticles! +
                                                                      1
                                                            });
                                                          });
                                                    /*  Future.delayed(
                                                        Duration(
                                                            milliseconds: 1500),
                                                        () {
                                                    
                                                    
                                                    
                                                    
                                                    */ /* 
                                                    SchedulerBinding.instance!
                                                        .addPostFrameCallback(
                                                            (_) { */

                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      '/Home',
                                                    );

                                                    //});
                                                    /* Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomeScreen(
                                                                          curIndex:
                                                                              0,
                                                                        )),
                                                            (route) => true); */
                                                    // });
                                                  }
                                                } else {
                                                  if (checked) {
                                                    if (galleryString.length >=
                                                        3) {
                                                      print(
                                                          'nnn with Photo with Gallery Image');
                                                      loadingCubit
                                                          .changeLoadingState(
                                                              false);

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'ArticleSubtype')
                                                          .where('SubType',
                                                              isEqualTo:
                                                                  selectedSubType)
                                                          .get()
                                                          .then((value) async {
                                                        if (value.size != 0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'ArticleSubtype')
                                                              .doc(value.docs
                                                                  .first.id)
                                                              .update({
                                                            'NoOfArticles':
                                                                noOfArticlesUnderCategory! +
                                                                    1
                                                          });
                                                        }
                                                      });

                                                      ArticlesModel model = ArticlesModel(
                                                          socialMediaLink:
                                                              socialLink,
                                                          sentNotificatonForPublished:
                                                              "False",
                                                          authorName:
                                                              this.authorName!,
                                                          authorUid:
                                                              this.authorUid!,
                                                          articleSubType:
                                                              selectedSubType!,
                                                          articletitle:
                                                              _titleController
                                                                  .text,
                                                          articledesc:
                                                              _descriptionController
                                                                  .text,
                                                          photoUrl: photoString ??
                                                              photoStringFromEdit,
                                                          noOfComment: '0',
                                                          noOfLike: '0',
                                                          peopleLike: [],
                                                          isArticlePublished:
                                                              'NotPublished',
                                                          isArticleReported:
                                                              'NotReported',
                                                          documentId:
                                                              documentId!,
                                                          hasImage: 'Yes',
                                                          createdTimeFieldValue:
                                                              FieldValue
                                                                  .serverTimestamp(),
                                                          bookMarkedPeoples: [],
                                                          noOfViews: 0,
                                                          reportedPeoples: [],
                                                          galleryImages:
                                                              galleryString,
                                                          updatedTimeFieldValue:
                                                              FieldValue
                                                                  .serverTimestamp());

                                                      widget.fromEdit
                                                          ? ArticlesDataBase()
                                                              .updateArticleInDB(
                                                                  documentId!,
                                                                  model
                                                                      .toJson())
                                                          : ArticlesDataBase()
                                                              .addArticleToDB(
                                                                  documentId!,
                                                                  model
                                                                      .toJson());
                                                      /* SchedulerBinding.instance!
                                                          .addPostFrameCallback(
                                                              (_) { */

                                                      Navigator
                                                          .pushReplacementNamed(
                                                        context,
                                                        '/Home',
                                                      );

                                                      //});
                                                    } else {
                                                      galleryFiles = [];
                                                      galleryString = [];
                                                      galleryCubit
                                                          .getImageForGallery(
                                                              null, null);
                                                      context
                                                          .read<
                                                              UploadgalleryimgCubit>()
                                                          .uploadGalleryImage(
                                                              tap: false);

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return tState
                                                                    .isLightTheme
                                                                ? ShowAlertNewDarkDialogBox(
                                                                    alertType:
                                                                        'Alert..!',
                                                                    alertMessage:
                                                                        'Minimum 3 Gallery Images Required')
                                                                : ShowAlertNewLightDialogBox(
                                                                    alertType:
                                                                        'Alert..!',
                                                                    alertMessage:
                                                                        'Minimum 3 Gallery Images Required');
                                                          });
                                                    }
                                                  } else {
                                                    print(
                                                        'nnn with Photo with Gallery Image');
                                                    loadingCubit
                                                        .changeLoadingState(
                                                            false);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'ArticleSubtype')
                                                        .where('SubType',
                                                            isEqualTo:
                                                                selectedSubType)
                                                        .get()
                                                        .then((value) async {
                                                      if (value.size != 0) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ArticleSubtype')
                                                            .doc(value
                                                                .docs.first.id)
                                                            .update({
                                                          'NoOfArticles':
                                                              noOfArticlesUnderCategory! +
                                                                  1
                                                        });
                                                      }
                                                    });
                                                    print(
                                                        'nnn social link $socialLink');
                                                    ArticlesModel model = ArticlesModel(
                                                        socialMediaLink:
                                                            socialLink,
                                                        sentNotificatonForPublished:
                                                            "False",
                                                        authorName:
                                                            this.authorName!,
                                                        authorUid:
                                                            this.authorUid!,
                                                        articleSubType:
                                                            selectedSubType!,
                                                        articletitle:
                                                            _titleController
                                                                .text,
                                                        articledesc:
                                                            _descriptionController
                                                                .text,
                                                        photoUrl: photoString ??
                                                            photoStringFromEdit,
                                                        noOfComment: '0',
                                                        noOfLike: '0',
                                                        peopleLike: [],
                                                        isArticlePublished:
                                                            'NotPublished',
                                                        isArticleReported:
                                                            'NotReported',
                                                        documentId: documentId!,
                                                        hasImage: 'Yes',
                                                        createdTimeFieldValue:
                                                            FieldValue
                                                                .serverTimestamp(),
                                                        bookMarkedPeoples: [],
                                                        noOfViews: 0,
                                                        reportedPeoples: [],
                                                        galleryImages:
                                                            galleryString,
                                                        updatedTimeFieldValue:
                                                            FieldValue
                                                                .serverTimestamp());

                                                    widget.fromEdit
                                                        ? ArticlesDataBase()
                                                            .updateArticleInDB(
                                                                documentId!,
                                                                model.toJson())
                                                        : ArticlesDataBase()
                                                            .addArticleToDB(
                                                                documentId!,
                                                                model.toJson());
/* 
                                                    SchedulerBinding.instance!
                                                        .addPostFrameCallback(
                                                            (_) { */

                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      '/Home',
                                                    );
                                                  }
                                                }
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return tState.isLightTheme
                                                          ? ShowAlertNewDarkDialogBox(
                                                              alertType:
                                                                  'Alert..!',
                                                              alertMessage:
                                                                  'Category Not Selected')
                                                          : ShowAlertNewLightDialogBox(
                                                              alertType:
                                                                  'Alert..!',
                                                              alertMessage:
                                                                  'Category Not Selected');
                                                    });
                                              }
                                            } else {
                                              print('nnn thmeState i tapped');
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return tState.isLightTheme
                                                        ? ShowAlertNewDarkDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Please Select Category')
                                                        : ShowAlertNewLightDialogBox(
                                                            alertType:
                                                                'Alert..!',
                                                            alertMessage:
                                                                'Please Select Category');
                                                  });
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: getWidth(context) * 0.15)
                                ],
                              ))
                        ]),
                      ],
                    ),
                  ))
                : Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber,
                  ));
          },
        ));
  }

  generateLink() async {
    var screen = '/Articles';
    var linkValue;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        navigationInfoParameters:
            NavigationInfoParameters(forcedRedirectEnabled: true),
        uriPrefix: 'https://journz.in',
        link: Uri.parse('https://journz.in/?type=$screen&id=$documentId'),
        androidParameters: AndroidParameters(
            fallbackUrl: Uri.parse(
                'https://play.google.com/store/apps/details?id=in.journz.journz'),
            packageName: "in.journz.journz",
            minimumVersion: 0),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: _titleController.text,
            description: _descriptionController.text,
            imageUrl: photoString != null ? Uri.parse(photoString!) : null));

    final ShortDynamicLink shortLinkParameter =
        await parameters.buildShortLink();
    linkValue = shortLinkParameter.shortUrl.toString();
    return linkValue;
  }
}
