import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/gender_cubit/pass_gender_cubit_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/marital_status_cubit/marital_status_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Add_Articles/cubits/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '../../UserProfile/Screen/user_profile_screen.dart';

class UserProfileEditScreen extends StatefulWidget {
  final CheckuserloginedState? userState;
  const UserProfileEditScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController anniversaryController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalController = TextEditingController();
  TextEditingController workController = TextEditingController();
  HtmlEditorController bioController = HtmlEditorController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController photoString = TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<CheckuserloginedCubit>().checkLogin();
    if (widget.userState != null) {
      firstNameController.text = widget.userState!.firstName!;
      lastNameController.text = widget.userState!.lastName!;
      if (widget.userState!.dateOfBirth != null) {
        dobController.text = widget.userState!.dateOfBirth!;
      } else {
        dobController.text = "Select Date";
      }
      if (widget.userState!.gender != null) {
        genderController.text = widget.userState!.gender!;
        context.read<PassGenderCubit>().whatGender(widget.userState!.gender!);
      } else {
        genderController.text = widget.userState!.gender ?? "Male";
      }
      if (widget.userState!.occupation != null) {
        workController.text = widget.userState!.occupation!;
      } else {
        workController.text = "Enter Your Work";
      }
      if (widget.userState!.photoUrl != null) {
        if (widget.userState!.photoUrl! != "WithoutImage") {
          print("nnn photo ${widget.userState!.photoUrl!}");
          context
              .read<AddphotoarticleCubit>()
              .givePhotoUrl(widget.userState!.photoUrl!, true);
        } else {
          context
              .read<AddphotoarticleCubit>()
              .givePhotoUrl(widget.userState!.photoUrl!, false);
        }
      }
      if (widget.userState!.linkedin != null) {
        linkedinController.text = widget.userState!.linkedin!;
      } else {
        linkedinController.text = "Add linkedin Link";
      }
      if (widget.userState!.facebook != null) {
        facebookController.text = widget.userState!.facebook!;
      } else {
        facebookController.text = "Add Facebook Link";
      }
      if (widget.userState!.twitter != null) {
        twitterController.text = widget.userState!.twitter!;
      } else {
        twitterController.text = "Add twitter Link";
      }
      if (widget.userState!.instagram != null) {
        instagramController.text = widget.userState!.instagram!;
      } else {
        instagramController.text = "Add Instagram Link";
      }
      if (widget.userState!.stateName != null) {
        stateController.text = widget.userState!.stateName!;
      } else {
        stateController.text = "State Name";
      }
      if (widget.userState!.anniversaryDate != null) {
        anniversaryController.text = widget.userState!.anniversaryDate!;
      } else {
        anniversaryController.text = "Select Date";
      }
      if (widget.userState!.maritalStatus != null) {
        context
            .read<MaritalStatusCubit>()
            .whatMarital(widget.userState!.maritalStatus!);
        maritalController.text = widget.userState!.maritalStatus!;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final addPhotoCubit = BlocProvider.of<AddphotoarticleCubit>(context);
    return Scaffold(body:
        BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, userState) {
      return userState.isLoggined!
          ? Container(
              width: context.screenWidth,
              height: context.screenHeight,
              child: Column(children: [
                HomePageHeader(wantSearchBar: true, fromMobile: false),
                Container(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.915,
                    child: Row(children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocBuilder<AddphotoarticleCubit,
                                      AddphotoarticleState>(
                                builder: (context, addPhotoState) {
                                  photoString.text = addPhotoState.photoURL!;
                                  //"https://firebasestorage.googleapis.com/v0/b/journzsocialnetwork.appspot.com/o/Articles%2FMind-Set%2Fimage_cropper_1636222654939.jpg?alt=media&token=72104bf6-2e02-4153-b87f-9575e6f5df6c";

                                  return InkWell(
                                    onTap: () {
                                      addPhotoCubit
                                          .uploadToStorage(userState.userUid!);
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.1,
                                      height: context.screenHeight * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: !addPhotoState.isPhotoUploaded!
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/add_photo.png'))
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      addPhotoState
                                                          .photoURL!))),
                                    ),
                                  );
                                },
                              )
                                  .box
                                  .width(context.screenWidth * 0.1)
                                  .height(context.screenHeight * 0.2)
                                  .makeCentered(),

                              /* userState.isLoggined!
                                  ? userState.photoUrl != "WithoutImage"
                                      ? Container(
                                          width: context.screenWidth * 0.1,
                                          height: context.screenHeight * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(250),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      userState.photoUrl!))),
                                        )
                                      : Image.asset("assets/images/logo.png")
                                  : Container(), */
                              Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    TextField(
                                      controller: firstNameController,
                                    )
                                        .box
                                        .width(context.screenWidth * 0.125)
                                        .height(context.screenHeight * 0.075)
                                        .make(),
                                    TextField(
                                      controller: lastNameController,
                                    )
                                        .box
                                        .width(context.screenWidth * 0.125)
                                        .height(context.screenHeight * 0.075)
                                        .make(),
                                  ])
                                  .box
                                  .width(context.screenWidth * 0.35)
                                  .height(context.screenHeight * 0.075)
                                  .make(),
                              //userState.name!.text.xl3.semiBold.make(),
                              userState.role == "ContentWriter"
                                  ? "Author".text.xl3.semiBold.make()
                                  : userState.role!.text.xl3.semiBold.make(),
                              userState.email!.text.xl.semiBold.make(),
                              ("${userState.countryCode} ${userState.mobileNumber}")
                                  .text
                                  .xl
                                  .semiBold
                                  .make(),

                              //  userState.email!.text.xl2.semiBold.make(),
                              (userState.stateName == null
                                      ? userState.country!
                                      : (userState.stateName! +
                                          ", " +
                                          userState.country!))
                                  .text
                                  .xl2
                                  .semiBold
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (userState.facebook! == "Add Link") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Facebook Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        launch(userState.facebook!);
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/facebookIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (userState.twitter! == "Add Link") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Twitter Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        launch(userState.twitter!);
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/twitterIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!(userState.linkedin! ==
                                          "Add Link")) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your LinkedIn Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        launch(userState.linkedin!);
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/linkedinIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!(userState.instagram! ==
                                          "Add Link")) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Instagram Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        launch(userState.instagram!);
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.035,
                                      height: context.screenHeight * 0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/instagram.png'))),
                                    ),
                                  ),
                                ],
                              )
                                  .box
                                  .height(context.screenHeight * 0.1)
                                  .width(context.screenWidth * 0.25)
                                  .make()
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    bioController.getText().then((value) {
                                      FirebaseFirestore.instance
                                          .collection("UserProfile")
                                          .doc(userState.userUid)
                                          .update({
                                        "FirstName":
                                            firstNameController.text.trim(),
                                        "LastName":
                                            lastNameController.text.trim(),
                                        "PhotoUrl": photoString.text.trim(),
                                        "DateOfBirth":
                                            dobController.text.trim(),
                                        "Gender": genderController.text.trim(),
                                        "StateName":
                                            stateController.text.trim(),
                                        "AnniversaryDate":
                                            anniversaryController.text.trim(),
                                        "MaritalStatus":
                                            maritalController.text.trim(),
                                        "Occupation":
                                            workController.text.trim(),
                                        "FacebookLink":
                                            facebookController.text.trim(),
                                        "LinkedinLink":
                                            linkedinController.text.trim(),
                                        "TwitterLink":
                                            twitterController.text.trim(),
                                        "InstagramLink":
                                            instagramController.text.trim(),
                                        "Bio": value
                                      }).then((value) =>
                                              context.vxNav.popToRoot());

                                      /* context.vxNav.push(
                                                Uri(
                                                    path: MyRoutes.homeRoute,
                                                    queryParameters: {
                                                      "Page": "/UserProfile"
                                                    }),
                                              ) */
                                    });
                                  },
                                  icon: Icon(Icons.done),
                                  label: Text('Done')))
                        ],
                      )
                          .box
                          .p8
                          .width(context.screenWidth * 0.3)
                          .height(context.screenHeight * 0.9)
                          .make(),
                      Container(
                        height: context.screenHeight * 0.93,
                        width: 2,
                        color: Colors.black,
                      ),
                      Container(
                        height: context.screenHeight * 0.93,
                        width: context.screenWidth * 0.698,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          EditUserDataInRow(
                                              left: "Date Of Birth",
                                              right: TextField(
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1950),
                                                          lastDate:
                                                              DateTime.now())
                                                      .then((value) {
                                                    if (value != null) {
                                                      dobController.text = value
                                                              .day
                                                              .toString() +
                                                          "-" +
                                                          value.month
                                                              .toString() +
                                                          "-" +
                                                          value.year.toString();
                                                    }
                                                  });
                                                },
                                                controller: dobController,
                                                readOnly: true,
                                              )),
                                          EditUserDataInRow(
                                              left: "Gender",
                                              right: BlocBuilder<
                                                  PassGenderCubit,
                                                  PassGenderState>(
                                                builder:
                                                    (context, genderState) {
                                                  genderController.text =
                                                      genderState.genderdata!;
                                                  return DropdownButton<String>(
                                                    value:
                                                        genderState.genderdata,
                                                    items: <String>[
                                                      'Male',
                                                      'Female',
                                                      'Neutral',
                                                      'Prefer Not to Say'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (val) {
                                                      genderController.text =
                                                          val!;
                                                      context
                                                          .read<
                                                              PassGenderCubit>()
                                                          .whatGender(val);
                                                    },
                                                  );
                                                },
                                              )),
                                          EditUserDataInRow(
                                              left: "State",
                                              right: TextField(
                                                  controller: stateController)),
                                          userState.role! == "ContentWriter"
                                              ? UserDataInRow(
                                                  left: "Published Articles",
                                                  right: userState
                                                      .noOfPublishedArticles
                                                      .toString())
                                              : Container()
                                        ])
                                        .box
                                        .p16
                                        .width(context.screenWidth * 0.349)
                                        .height(context.screenHeight * 0.325)
                                        .make(),
                                    Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          EditUserDataInRow(
                                              left: "Anniversary Date",
                                              right: TextField(
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1950),
                                                          lastDate:
                                                              DateTime.now())
                                                      .then((value) {
                                                    if (value != null) {
                                                      anniversaryController
                                                          .text = value.day
                                                              .toString() +
                                                          "-" +
                                                          value.month
                                                              .toString() +
                                                          "-" +
                                                          value.year.toString();
                                                    }
                                                  });
                                                },
                                                controller:
                                                    anniversaryController,
                                                readOnly: true,
                                              )),
                                          EditUserDataInRow(
                                              left: "Marital Status",
                                              right: BlocBuilder<
                                                  MaritalStatusCubit,
                                                  MaritalStatusState>(
                                                builder:
                                                    (context, maritalState) {
                                                  maritalController.text =
                                                      maritalState.marital!;
                                                  return DropdownButton<String>(
                                                    value: maritalState.marital,
                                                    items: <String>[
                                                      "Single",
                                                      "Married"
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (val) {
                                                      maritalController.text =
                                                          val!;
                                                      context
                                                          .read<
                                                              MaritalStatusCubit>()
                                                          .whatMarital(val);
                                                    },
                                                  );
                                                },
                                              )),
                                          EditUserDataInRow(
                                              left: "Work",
                                              right: TextField(
                                                  controller: workController))
                                        ])
                                        .box
                                        .p16
                                        .width(context.screenWidth * 0.349)
                                        .height(context.screenHeight * 0.325)
                                        .make(),
                                  ]),
                              Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    EditUserLinkDataInRow(
                                        left: "Facebook",
                                        right: TextField(
                                            controller: facebookController)),
                                    EditUserLinkDataInRow(
                                        left: "Instagram",
                                        right: TextField(
                                            controller: instagramController)),
                                    EditUserLinkDataInRow(
                                        left: "Twitter",
                                        right: TextField(
                                            controller: twitterController)),
                                    EditUserLinkDataInRow(
                                        left: "Linkedin",
                                        right: TextField(
                                            controller: linkedinController)),
                                  ])
                                  .box
                                  .p16
                                  .width(context.screenWidth * 0.698)
                                  .make(),
                              Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    "Bio"
                                        .text
                                        .xl2
                                        .semiBold
                                        .make()
                                        .box
                                        .p16
                                        .width(context.screenWidth * 0.15)
                                        .height(context.screenHeight * 0.05)
                                        .make(),
                                    SizedBox(height: 8),
                                    Flexible(
                                      child: HtmlEditor(
                                        htmlToolbarOptions: HtmlToolbarOptions(
                                          dropdownBackgroundColor: Colors.white,
                                          initiallyExpanded: true,
                                          defaultToolbarButtons: [
                                            StyleButtons(),
                                            FontSettingButtons(
                                                fontSizeUnit: false),
                                            FontButtons(
                                                clearAll: false,
                                                subscript: false,
                                                strikethrough: false,
                                                superscript: false),
                                            // ColorButtons(),
                                            ListButtons(listStyles: false),
                                            ParagraphButtons(
                                                caseConverter: false,
                                                textDirection: false),
                                            InsertButtons(
                                                audio: false,
                                                hr: false,
                                                link: false,
                                                otherFile: false,
                                                picture: false,
                                                table: false,
                                                video: false)
                                          ],
                                          toolbarPosition:
                                              ToolbarPosition.aboveEditor,
                                          toolbarType: ToolbarType.nativeGrid,
                                        ),
                                        controller: bioController, //required
                                        otherOptions: OtherOptions(
                                            height:
                                                context.screenHeight * 0.75),
                                        htmlEditorOptions: HtmlEditorOptions(
                                          initialText: widget.userState!.bio !=
                                                  null
                                              ? widget.userState!.bio!
                                              : "<div>You can Update your Bio by Expressing Who You Are</div>",
                                          adjustHeightForKeyboard: false,
                                          autoAdjustHeight: false,
                                          hint: "Please Enter Bio Here...",
                                        ),
                                      ),
                                    )
                                  ])
                                  .box
                                  .width(context.screenWidth * 0.675)
                                  .height(context.screenHeight * 0.75)
                                  .make(),
                            ]).scrollVertical(),
                      )
                    ]))
              ]),
            )
          : Center(
              child: Text('Not Logged In'),
            );
    }));
  }
}

class EditUserDataInRow extends StatelessWidget {
  final String left;

  final Widget right;
  const EditUserDataInRow({Key? key, required this.left, required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        left
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.125)
            .make(),
        "-".text.xl.semiBold.make(),
        SizedBox(width: context.screenWidth * 0.0075),
        right.box.alignCenterLeft.width(context.screenWidth * 0.15).make(),
      ],
    )
        .box
        .height(context.screenHeight * 0.065)
        .width(context.screenWidth * 0.35)
        .make();
  }
}

class EditUserLinkDataInRow extends StatelessWidget {
  final String left;
  final Widget right;
  const EditUserLinkDataInRow(
      {Key? key, required this.left, required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        left
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.125)
            .make(),
        "-".text.xl.semiBold.make(),
        SizedBox(width: context.screenWidth * 0.0075),
        right.box.alignCenterLeft.width(context.screenWidth * 0.35).make(),
      ],
    )
        .box
        .height(context.screenHeight * 0.065)
        .width(context.screenWidth * 0.65)
        .make();
  }
}
