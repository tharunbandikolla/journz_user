import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import '/UserProfile/Screen/NewUserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfileDataEditScreen extends StatefulWidget {
  String photoUrl, name, email, mobileNumber, userName;
  UserProfileDataEditScreen(
      {Key? key,
      required this.photoUrl,
      required this.email,
      required this.userName,
      required this.mobileNumber,
      required this.name})
      : super(key: key);

  @override
  _UserProfileDataEditScreenState createState() =>
      _UserProfileDataEditScreenState();
}

class _UserProfileDataEditScreenState extends State<UserProfileDataEditScreen> {
  File? photoFile;

  String? photoString;

  bool checkAddPhotoAfterUpload = false;

  bool checkAddPhotoBeforeUpload = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  @override
  void initState() {
    print('nnn pho ${widget.photoUrl}');
    nameController.text = widget.name;
    emailController.text = widget.email;
    mobileNumberController.text = '+91 ${widget.mobileNumber}';
    userNameController.text = widget.userName;
    photoString = widget.photoUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addPhotoCubit = BlocProvider.of<AddphotoarticleCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
            builder: (context, tState) {
              return VStack([
                Container(
                  width: getWidth(context),
                  child:
                      BlocBuilder<AddphotoarticleCubit, AddphotoarticleState>(
                          builder: (context, state) {
                    photoFile = state.articlePhotoFile;
                    state.photoURL == null
                        ? photoString = widget.photoUrl
                        : photoString = state.photoURL;
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
                                width: getWidth(context) * 0.55,
                                height: getWidth(context) * 0.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        getWidth(context) * 0.05),
                                    shape: BoxShape.rectangle,
                                    image: widget.photoUrl !=
                                            "images/fluenzologo.png"
                                        ? DecorationImage(
                                            image:
                                                NetworkImage(widget.photoUrl),
                                            fit: BoxFit.fill)
                                        : DecorationImage(
                                            image: AssetImage(
                                                'images/fluenzologo.png'),
                                            fit: BoxFit.fill)),
                              )
                            : Container(
                                width: getWidth(context) * 0.55,
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
                          child: IconButton(
                              onPressed: () {
                                if (state.isPhotoUploaded!) {
                                  print('nnn p remove');
                                  addPhotoCubit.closeSelectedPhoto();
                                  photoFile = null;
                                  photoString = null;
                                  checkAddPhotoBeforeUpload = false;
                                  checkAddPhotoAfterUpload = false;
                                  //setState(() {});
                                } else {
                                  print('nnn p add');
                                  addPhotoCubit.getPhoto(
                                      'UserProfile\${widget.userName}',
                                      ctx: context);
                                  print('nnn bool brfore Pressed ');
                                  checkAddPhotoBeforeUpload = true;
                                  print('nnn bool After Pressed ');
                                }
                              },
                              icon: Icon(
                                  state.isPhotoUploaded!
                                      ? Icons.close
                                      : Icons.add_a_photo,
                                  size: 30)),
                        ),
                      ],
                    );
                  }),
                )
                    .box
                    .p24
                    .width(context.screenHeight * 0.6)
                    .height(context.screenWidth * 0.6)
                    .makeCentered(),
                "Please wait Until The Selected Image Will Display Above"
                    .text
                    .lg
                    .center
                    .make()
                    .box
                    .px8
                    .make(),
                15.heightBox,
                TextField(
                  controller: nameController,
                ),
                TextField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return tState.isLightTheme
                              ? ShowAlertNewDarkDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Username Can\'t Change (Read Only)')
                              : ShowAlertNewLightDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Username Can\'t Change (Read Only)');
                        });
                  },
                  controller: userNameController,
                  readOnly: true,
                ),
                TextField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return tState.isLightTheme
                              ? ShowAlertNewDarkDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Mobile Number Can\'t Change (Read Only)')
                              : ShowAlertNewLightDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Mobile Number Can\'t Change (Read Only)');
                        });
                  },
                  controller: mobileNumberController,
                  readOnly: true,
                ),
                TextField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return tState.isLightTheme
                              ? ShowAlertNewDarkDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Email Can\'t Change (Read Only)')
                              : ShowAlertNewLightDialogBox(
                                  alertType: 'Warning..!',
                                  alertMessage:
                                      'Email Can\'t Change (Read Only)');
                        });
                  },
                  controller: emailController,
                  readOnly: true,
                ),
                //Spacer(),
                ElevatedButton(
                        onPressed: () {
                          print('nn $photoString ');
                          if (photoString != null) {
                            if (nameController.text.isNotEmpty) {
                              FirebaseFirestore.instance
                                  .collection('UserProfile')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'PhotoUrl': photoString,
                                'Name': nameController.text.trim()
                              }).then((value) {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewUserProfileScreen()));
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShowAlertDialogBox(
                                        alertType: 'Warning..!',
                                        alertMessage: 'Please Enter Your Name');
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShowAlertDialogBox(
                                      alertType: 'Warning..!',
                                      alertMessage:
                                          'Please Select Profile Photo');
                                });
                          }
                        },
                        child: Text('Update'))
                    .box
                    .p64
                    .makeCentered()
              ]);
            },
          )
              .box
              .p16
              .width(context.screenWidth)
              .height(context.screenHeight * 0.95)
              .make(),
        ));
  }
}
