import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Journz_Large_Screen/Common/Cubits/Show_Loading_Screen_Cubit.dart/show_loading_screen_cubit.dart';
import '../../../Journz_Large_Screen/Common/Data/country.dart';
import '../../../Journz_Large_Screen/Common/Data/user_terms_condition.dart';
import '../../../Journz_Large_Screen/NewHomePage/Cubits/PassCountrySearchTextCubit/pass_country_search_text_cubit.dart';
import '../../../Journz_Large_Screen/NewHomePage/Cubits/SelectCountryAtSignupCubit/select_country_at_signup_cubit.dart';
import '../../../Journz_Large_Screen/NewHomePage/Cubits/ShowCountryCodeAtSignUpUiCubit/show_country_code_at_signup_ui_cubit.dart';
import '../../../Journz_Large_Screen/NewHomePage/Helper/signup_data_model.dart';
import '../../../Journz_Large_Screen/utils/routes.dart';
import '../../../Journz_Mobile/Authentication/Component/mobile_form_field.dart';
import '../../../Journz_Mobile/Authentication/Cubits/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '../../../Journz_Mobile/Authentication/Cubits/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '../../../Journz_Mobile/Authentication/Cubits/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';

class TabSignupScreen extends StatefulWidget {
  const TabSignupScreen({Key? key}) : super(key: key);

  @override
  _TabSignupScreenState createState() => _TabSignupScreenState();
}

class _TabSignupScreenState extends State<TabSignupScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController reEnterPassword = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  final TextEditingController countryName = TextEditingController();
  final GlobalKey<FormState> accSignUpFormkey = GlobalKey<FormState>();

  bool checked = false;

  String? token;

  @override
  Widget build(BuildContext context) {
    final checkBoxCubit = BlocProvider.of<SignupcheckboxCubit>(context);
    // final signupCubit = BlocProvider.of<SignupCubit>(context);
    // final loadingscreenCubit = BlocProvider.of<LoadingscreenCubit>(context);
    final passwordCubit =
        BlocProvider.of<ShowhidepasswordinsignupCubit>(context);
    final reEnterPasswordCubit =
        BlocProvider.of<ShowHideReEnterPasswordCubit>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: context.screenWidth,
          height: context.screenWidth * 2.25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.35), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image:
                      const AssetImage('assets/images/AuthenticationBG.jpg'))),
          child: Form(
              key: accSignUpFormkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*  //SizedBox(height: context.screenWidth * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/journzpng2.png')
                          .box
                          .width(context.screenWidth * 0.145)
                          .height(context.screenWidth * 0.145)
                          .makeCentered(),
                      //SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "JOURNZ"
                              .text
                              .white
                              .xl3
                              .bold
                              .letterSpacing(context.screenWidth * 0.01)
                              .make(),
                          "Journal of Your Lifetime Journey"
                              .text
                              .white
                              .medium

//                            .letterSpacing(1.5)
                              .align(TextAlign.right)
                              // .bold
                              .make(),
                        ],
                      )
                    ],
                  ).box.px12.width(context.screenWidth * 0.85).make(),
                  //SizedBox(height: context.screenWidth * 0.05), */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //SizedBox(width: context.screenWidth * 0.075),
                      Image.asset('assets/images/journzpng2.png')
                          .box
                          .width(context.screenWidth * 0.15)
                          .height(context.screenWidth * 0.15)
                          .makeCentered(),
                      //SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "JOURNZ"
                              .text
                              .white
                              .xl4
                              .bold
                              .letterSpacing(context.screenWidth * 0.01)
                              .make(),
                          "Journal of Your Lifetime Journey"
                              .text
                              .xl
                              .white
                              .medium

//                            .letterSpacing(1.5)
                              .align(TextAlign.right)
                              // .bold
                              .make(),
                        ],
                      )
                          .box
                          .width(context.screenWidth * 0.75)
                          .height(context.screenWidth * 0.15)
                          .makeCentered(),
                    ],
                  )
                      .box
                      .width(context.screenWidth)
                      .height(context.screenWidth * 0.2)
                      .makeCentered(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NewTextFormField(
                          keyBoardType: TextInputType.name,
                          readOnly: false,
                          newHeight: context.screenWidth * 0.175,
                          newWidth: context.screenWidth * 0.45,
                          hintText: 'First Name',
                          controller: firstName,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter a Valid Name';
                            } else {
                              return null;
                            }
                          }),
                      NewTextFormField(
                          keyBoardType: TextInputType.name,
                          readOnly: false,
                          newHeight: context.screenWidth * 0.15,
                          newWidth: context.screenWidth * 0.45,
                          hintText: 'Last Name',
                          controller: lastName,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter a Valid Name';
                            } else {
                              return null;
                            }
                          })
                    ],
                  )
                      .box
                      .width(context.screenWidth)
                      .height(context.screenWidth * 0.09)
                      .px16
                      .make(),
                  //SizedBox(height: 8),
                  NewTextFormField(
                      keyBoardType: TextInputType.emailAddress,
                      readOnly: false,
                      hintText: 'Email',
                      controller: email,
                      validator: (val) {
                        if (!RegExp(r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                caseSensitive: false)
                            .hasMatch(val!)) {
                          return 'Enter a Valid Email';
                        } else {
                          return null;
                        }
                      }).box.py8.px16.make(),
                  //SizedBox(height: context.screenWidth * 0.02),
                  NewTextFormField(
                      keyBoardType: TextInputType.name,
                      readOnly: false,
                      hintText: 'User Name',
                      controller: userName,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter a Valid Name';
                        } else {
                          return null;
                        }
                      }).box.py16.px16.make(),
                  //SizedBox(height: context.screenWidth * 0.02),
                  BlocBuilder<ShowhidepasswordinsignupCubit,
                      ShowhidepasswordinsignupState>(
                    builder: (context, passwordState) {
                      return TextFormField(
                        controller: password,
                        obscureText: passwordState.passWordInSignup,
                        onFieldSubmitted: (String v) {},
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (!RegExp(
                                  r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                              .hasMatch(val!)) {
                            return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Colors.black.withOpacity(0.35),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordState.passWordInSignup) {
                                    passwordCubit
                                        .updateSignUpPasswordBool(false);
                                  } else {
                                    passwordCubit
                                        .updateSignUpPasswordBool(true);
                                  }
                                },
                                icon: passwordState.passWordInSignup
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.screenWidth * 0.5)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.05,
                                vertical: context.screenWidth * 0.04),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white)),
                      );
                    },
                  ).box.py16.px16.make(),
                  //SizedBox(height: context.screenWidth * 0.02),
                  BlocBuilder<ShowHideReEnterPasswordCubit,
                      ShowHideReEnterPasswordState>(
                    builder: (context, passwordState) {
                      return TextFormField(
                        controller: reEnterPassword,
                        obscureText: passwordState.showHideReEnterPassWord,
                        onFieldSubmitted: (String v) {},
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (!RegExp(
                                  r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                              .hasMatch(val!)) {
                            return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Colors.black.withOpacity(0.35),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordState.showHideReEnterPassWord) {
                                    reEnterPasswordCubit
                                        .updateShowHidePasswordBool(false);
                                  } else {
                                    reEnterPasswordCubit
                                        .updateShowHidePasswordBool(true);
                                  }
                                },
                                icon: passwordState.showHideReEnterPassWord
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.screenWidth * 0.5)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.05,
                                vertical: context.screenWidth * 0.04),
                            hintText: 'Re-Password',
                            hintStyle: const TextStyle(color: Colors.white)),
                      );
                    },
                  ).box.py16.px16.make(),
                  //SizedBox(height: context.screenWidth * 0.01),
                  "Password must contain('A-Z' 'a-z' '0-9' '@#')"
                      .text
                      .white
                      .lg
                      .makeCentered()
                      .box
                      .py16
                      .px16
                      .make(),
                  //SizedBox(height: context.screenWidth * 0.025),
                  /* NewTextFormField(
                      keyBoardType: TextInputType.multiline,
                      readOnly: true,
                      onTap: () {
                        /*      showCountryPicker(
                            showPhoneCode: true,
                            context: context,
                            onSelect: (Country? country) {
                              _countryController.text = country!.name;
                              _countryCodeController.text =
                                  "+${country.phoneCode}";
                            }); */
                      },
                      hintText: 'Tap to Select Country',
                      controller: _countryController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Select A Country';
                        }
                      }).box.py16.px16.make(),
                  //SizedBox(height: context.screenWidth * 0.02),
                  NewTextFormField(
                      keyBoardType: TextInputType.phone,
                      prefixWidget: Text(_countryCodeController.text),
                      readOnly: false,
                      hintText: 'Mobile Number',
                      controller: _mobileNumberController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter 10 Digit Mobile Number';
                        } else if (val.length != 10) {
                          return 'Enter 10 Digit Mobile Number';
                        }
                      }).box.py8.px16.make(), */
                  BlocBuilder<ShowCountryCodeAtSignupUiCubit,
                      ShowCountryCodeAtSignupUiState>(
                    builder: (context, countryCodeAtUiState) {
                      countryCode.text = countryCodeAtUiState.code;

                      countryName.text = countryCodeAtUiState.country;
                      return TextFormField(
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter 10 Digit Mobile Number';
                          } else if (val.length != 10) {
                            return 'Enter 10 Digit Mobile Number';
                          }
                        },
                        controller: mobileNumber,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            prefix: TextButton(
                              onPressed: () {
                                getSelectedCountryDetails(
                                    String name, String code) {
                                  print('nnn names Codes  ');
                                  context
                                      .read<ShowCountryCodeAtSignupUiCubit>()
                                      .listenForCountryCode(code, name);
                                  countryName.text = name;
                                  countryCode.text = code;
                                }

                                showCountryDialog(
                                    context,
                                    getSelectedCountryDetails,
                                    countryName.text,
                                    countryCode.text);
                              },
                              child: Text(
                                countryCodeAtUiState.code,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            filled: true,
                            //isDense: true,
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.black.withOpacity(0.35),
                            hintText: 'Mobile Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.screenWidth * 0.05))),
                      );
                    },
                  ).box.px16.height(context.screenWidth * 0.135).make(),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Terms & Condition"),
                              content: Text(userTerms),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Close")),
                              ],
                            );
                          });
                    },
                    child: "Please Read Terms & Conditions"
                        .text
                        .white
                        .bold
                        .lg
                        .underline
                        .makeCentered()
                        .box
                        .alignCenterLeft
                        .height(context.screenWidth * 0.05)
                        .width(context.screenWidth)
                        .make(),
                  ).box.py16.make(),
                  BlocBuilder<SignupcheckboxCubit, SignupcheckboxState>(
                    builder: (context, state) {
                      checked = state.check;
                      token = state.token;

                      return CheckboxListTile(
                        title: "Agree All Terms & Conditions."
                            .text
                            .white
                            .bold
                            .xl
                            .make(),
                        value: state.check,
                        onChanged: (newValue) {
                          checkBoxCubit.checkToggle(newValue);
                          FocusScope.of(context).unfocus();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                          .box
                          .alignCenter
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.2)
                          .makeCentered();
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (accSignUpFormkey.currentState!.validate()) {
                          accSignUpFormkey.currentState!.save();

                          if (checked) {
                            if (password.text == reEnterPassword.text) {
                              FirebaseFirestore.instance
                                  .collection('UserName')
                                  .where('UserName',
                                      isEqualTo: userName.text.trim())
                                  .get()
                                  .then((value) {
                                if (value.size != 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert"),
                                          content:
                                              Text("UserName Already Exist"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Close"))
                                          ],
                                        );
                                      });
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('UserName')
                                      .where('Email',
                                          isEqualTo: email.text.trim())
                                      .get()
                                      .then((val) {
                                    if (val.size != 0) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Alert"),
                                              content:
                                                  Text("Email Already Exist"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Close"))
                                              ],
                                            );
                                          });
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('UserName')
                                          .where('MobileNumber',
                                              isEqualTo:
                                                  mobileNumber.text.trim())
                                          .get()
                                          .then((v) {
                                        if (v.size != 0) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Alert"),
                                                  content: Text(
                                                      "MobileNumber Already Exist"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Close"))
                                                  ],
                                                );
                                              });
                                        } else {
                                          context
                                              .read<ShowLoadingScreenCubit>()
                                              .startLoading(true);
                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: email.text.trim(),
                                                  password:
                                                      password.text.trim())
                                              .then((usr) {
                                            if (usr.user != null) {
                                              FirebaseMessaging.instance
                                                  .getToken(
                                                      vapidKey:
                                                          "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
                                                  .then((token) {
                                                String uid = FirebaseAuth
                                                    .instance.currentUser!.uid;
                                                SignUpDataModel userProfileData =
                                                    SignUpDataModel(
                                                        notificationToken:
                                                            token,
                                                        role: 'User',
                                                        firstName: firstName.text
                                                            .trim(),
                                                        lastName: lastName.text
                                                            .trim(),
                                                        email:
                                                            email.text.trim(),
                                                        disableTill: null,
                                                        countryCode: countryCode
                                                            .text
                                                            .trim(),
                                                        countryName: countryName
                                                            .text
                                                            .trim(),
                                                        isDisable: 'False',
                                                        noOfArticlesPostedByAuthor:
                                                            0,
                                                        authorPermissionRequest:
                                                            "False",
                                                        mobileNumber:
                                                            mobileNumber.text
                                                                .trim(),
                                                        name:
                                                            '${firstName.text.trim()} ${lastName.text.trim()}',
                                                        isMobileNumberVerified:
                                                            'Verified',
                                                        userName: userName.text
                                                            .trim(),
                                                        userFavouriteArticle: [
                                                          "Social Issues"
                                                        ],
                                                        photoUrl:
                                                            'images/fluenzologo.png',
                                                        userCountryPreferences: [
                                                          'All',
                                                          countryName.text
                                                              .trim()
                                                        ],
                                                        userUID: uid);

                                                print("User uid $uid");

                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'GeneralWebUserNotificationToken')
                                                    .doc(uid)
                                                    .set({
                                                  'NotificationToken': token
                                                });

                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'PublicNotification')
                                                    .doc(uid)
                                                    .set({
                                                  'NotificationToken': token
                                                });
                                                print(
                                                    "User Profile Data $userProfileData");
                                                FirebaseFirestore.instance
                                                    .collection('UserProfile')
                                                    .doc(uid)
                                                    .set(userProfileData
                                                        .toJson());

                                                FirebaseFirestore.instance
                                                    .collection('UserName')
                                                    .doc(uid)
                                                    .set({
                                                  'Email': email.text.trim(),
                                                  'UserName':
                                                      userName.text.trim(),
                                                  'MobileNumber':
                                                      mobileNumber.text.trim()
                                                });

                                                FirebaseAuth
                                                    .instance.currentUser!
                                                    .sendEmailVerification();

                                                context.vxNav.push(
                                                  Uri(
                                                      path: MyRoutes.homeRoute,
                                                      queryParameters: {
                                                        "Page": "/SignUpSuccess"
                                                      }),
                                                );

                                                context
                                                    .read<
                                                        ShowLoadingScreenCubit>()
                                                    .startLoading(false);
                                              });
                                            }
                                          }).onError((error, stackTrace) => context
                                                  .read<
                                                      ShowLoadingScreenCubit>()
                                                  .startLoading(false));

                                          //This Commented part made Mobile Verification
                                          /*  context
                                                                          .read<
                                                                              GoToMpinCubit>()
                                                                          .listenForTask(
                                                                              1); */
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Alert"),
                                      content:
                                          Text("Please Check Password Entered"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Close"))
                                      ],
                                    );
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Alert"),
                                    content:
                                        Text("Please Check Terms & Conditions"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Close"))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                  //SizedBox(height: context.screenWidth * 0.03),
                  InkWell(
                    onTap: () {
                      context.vxNav.push(
                        Uri(
                            path: MyRoutes.homeRoute,
                            queryParameters: {"Page": "/MobileLogin"}),
                      );
                    },
                    child: "Already a Journz Member..! Sign in here."
                        .text
                        .white
                        .lg
                        .bold
                        .makeCentered()
                        .box
                        .py16
                        .px16
                        .make(),
                  ),
                  //SizedBox(height: 50)
                ],
              ))),
    ));
  }

  showCountryDialog(BuildContext context, Function(String, String) func,
      String? name, String? code) {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController searchCountryController =
              TextEditingController();
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PassCountrySearchTextCubit(),
              ),
              BlocProvider(
                create: (context) => SelectCountryAtSignupCubit(
                    countryCode: code, countryName: name),
              ),
            ],
            child: BlocBuilder<PassCountrySearchTextCubit,
                PassCountrySearchTextState>(
              builder: (context, searchTextState) {
                return BlocBuilder<SelectCountryAtSignupCubit,
                    SelectCountryAtSignupState>(
                  builder: (context, selectedCountryState) {
                    /* nameController.text =
                      selectedCountryState.selectedCountry ?? "India";
                  codeController.text =
                      selectedCountryState.selectedCountryCode ?? '+91'; */
                    return Dialog(
                      child: Column(
                        children: [
                          TextField(
                              controller: searchCountryController,
                              onChanged: (val) {
                                context
                                    .read<PassCountrySearchTextCubit>()
                                    .listenSearchText(val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Search Country',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        context
                                            .read<PassCountrySearchTextCubit>()
                                            .listenSearchText("");
                                        searchCountryController.clear();
                                      },
                                      icon: Icon(Icons.close)))),
                          //SizedBox(height: context.screenWidth * 0.03),
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: countryCodes.length,
                            itemBuilder: (context, index) {
                              return countryCodes[index]['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          searchTextState.searchText ?? '')
                                  ? CheckboxListTile(
                                      title: Text(countryCodes[index]['name']),
                                      value: selectedCountryState
                                              .selectedCountry ==
                                          countryCodes[index]['name']
                                              .toString(),
                                      onChanged: (val) {
                                        func(
                                            countryCodes[index]['name']
                                                .toString(),
                                            countryCodes[index]['code']
                                                .toString());
                                        context
                                            .read<SelectCountryAtSignupCubit>()
                                            .listenSelectedCountry(
                                                countryCodes[index]['name']
                                                    .toString(),
                                                countryCodes[index]['code']
                                                    .toString());
                                        Navigator.pop(context);
                                      })
                                  : Container();
                            },
                          )
                              .box
                              .width(context.screenWidth * 0.8)
                              .height(context.screenWidth * 1.15)
                              .make(),
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(context.screenWidth * 0.005))
                          .width(context.screenWidth)
                          .height(context.screenWidth * 1.25)
                          .make(),
                    );
                  },
                );
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    firstName.clear();
    lastName.clear();
    email.clear();
    userName.clear();
    password.clear();
    reEnterPassword.clear();
    mobileNumber.clear();
    countryCode.clear();
    countryName.clear();

    super.dispose();
  }
}
