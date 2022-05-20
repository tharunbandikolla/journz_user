import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '/Journz_Large_Screen/Common/Data/country.dart';
import '/Journz_Large_Screen/Common/Data/user_terms_condition.dart';
import '/Journz_Large_Screen/Common/Helper/dialogs.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/AgreeTermsAndConditionscubit/agree_terms_conditions_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/GoToMpinCubit/go_to_mpin_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/PassCountrySearchTextCubit/pass_country_search_text_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/PassVerificationIdCubit/pass_verification_id_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/SelectCountryAtSignupCubit/select_country_at_signup_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCountryCodeAtSignUpUiCubit/show_country_code_at_signup_ui_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowHideLoginPasswordCubit/show_hide_login_password_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowHideSignupPassword/show_hide_signup_password_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowHideSignupReEnterPasswordCubit/show_hide_signup_reenter_password_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Helper/fav_articles_sharedpref.dart';
import '/Journz_Large_Screen/NewHomePage/Helper/search_suggestion.dart';
import '/Journz_Large_Screen/NewHomePage/Helper/signup_data_model.dart';
import '/Journz_Large_Screen/NewHomePage/Helper/signup_database.dart';
import '/Journz_Large_Screen/utils/routes.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class TabHomePageHeader extends StatefulWidget {
  final bool? wantSearchBar;
  const TabHomePageHeader({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<TabHomePageHeader> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? email;

  TextEditingController forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * 0.085,
      color: Colors.blue.shade400,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: context.screenWidth * 0.0115),
            width: context.screenWidth * 0.35,
            height: context.screenHeight * 0.085,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      context.vxNav.popToRoot();
                    },
                    child: Image.asset(
                      'assets/images/journzlogo1.png',
                      color: Colors.white,
                    )),
                InkWell(
                    onTap: () {
                      context.vxNav.popToRoot();
                    },
                    child: "JOURNZ".text.bold.white.xl2.makeCentered())
              ],
            ),
          ),
          widget.wantSearchBar!
              ? Container(
                  alignment: Alignment.center,
                  //width: context.screenWidth * 0.3,
                  width: context.screenWidth * 0.35,
                  height: context.screenHeight * 0.045,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius:
                          BorderRadius.circular(context.screenWidth * 0.05)),
                  child: TypeAheadField<SearchSuggestionData>(
                    debounceDuration: Duration(milliseconds: 100),
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Search...'),
                    ),
                    noItemsFoundBuilder: (context) {
                      return Text('No Articles Found');
                    },
                    suggestionsCallback: (pattern) async {
                      return await FirebaseFirestore.instance
                          .collection('NewArticleCollection')
                          .get()
                          .then((value) => value.docs
                                  .map((e) => SearchSuggestionData.fromJson(e))
                                  .where((element) {
                                final tlower =
                                    element.articletitle.toLowerCase();
                                final qLower = pattern.toLowerCase();
                                return tlower.contains(qLower);
                              }).toList());
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.articletitle),
                        subtitle: Text(suggestion.articleSubtype),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      context.vxNav.push(
                          Uri(path: MyRoutes.homeRoute, queryParameters: {
                            "Page": "/Articles",
                            "id": suggestion.docId
                          }),
                          params: HiveArticleData());
                    },
                  ),
                )
              : Container(),
          SizedBox(width: context.screenWidth * 0.15),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  loginFunc(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return BlocProvider(
            create: (context) => ShowHideLoginPasswordCubit(),
            child: Dialog(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        context.screenSize.aspectRatio * 8)),
                width: context.screenWidth * 0.7,
                height: context.screenHeight * 0.85,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: context.screenWidth * 0.3,
                          height: context.screenHeight * 0.85,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/login.jpeg'))),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close)),
                        ),
                      ])
                          .box
                          .width(context.screenWidth * 0.35)
                          .height(context.screenHeight * 0.7)
                          .make(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "Join To Drink Immortal Content".text.xl2.bold.make(),
                          SizedBox(
                              width: context.screenWidth,
                              height: context.screenHeight * 0.045),
                          TextField(
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintText: "Email",
                                  ))
                              .box
                              .width(context.screenWidth * 0.25)
                              .height(context.screenHeight * 0.075)
                              .make(),
                          SizedBox(
                              width: context.screenWidth,
                              height: context.screenHeight * 0.025),
                          BlocBuilder<ShowHideLoginPasswordCubit,
                                  ShowHideLoginPasswordState>(
                            builder: (context, shPasswordstate) {
                              return TextField(
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          context
                                              .read<
                                                  ShowHideLoginPasswordCubit>()
                                              .getvisibility(
                                                  !shPasswordstate.visibleOff);
                                        },
                                        icon: shPasswordstate.visibleOff
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility))),
                                obscureText: shPasswordstate.visibleOff,
                              );
                            },
                          )
                              .box
                              .width(context.screenWidth * 0.25)
                              .height(context.screenHeight * 0.075)
                              .make(),
                          SizedBox(
                              width: context.screenWidth,
                              height: context.screenHeight * 0.045),
                          ElevatedButton(
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  if (RegExp(r'[0-9]{10}$')
                                      .hasMatch(emailController.text.trim())) {
                                    print(
                                        'nnn which  mobile number Slot ${emailController.text}');
                                    FirebaseFirestore.instance
                                        .collection("UserName")
                                        .where("MobileNumber",
                                            isEqualTo:
                                                emailController.text.trim())
                                        .get()
                                        .then((value) {
                                      if (value.size != 0) {
                                        value.docs.forEach((element) async {
                                          email = await element
                                              .data()['Email']
                                              .toString();
                                        });

                                        Future.delayed(
                                            const Duration(milliseconds: 700),
                                            () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: email!,
                                                    password: passwordController
                                                        .text
                                                        .trim())
                                                .whenComplete(() async {
                                              FirebaseAuth.instance.currentUser
                                                  ?.reload();

                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                context.vxNav.push(Uri(
                                                    path: MyRoutes.homeRoute));
                                              }
                                            });
                                          } catch (e) {
                                            throw Exception(e);
                                          }
                                        });
                                      } else {
                                        ShowErrorDialogNormal(context,
                                            'Mobile Number Not Matching With Records');
                                      }
                                    });
                                  } else if (RegExp(
                                          r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                          caseSensitive: false)
                                      .hasMatch(emailController.text.trim())) {
                                    print(
                                        'nnn which Email Slot ${emailController.text}');
                                    FirebaseFirestore.instance
                                        .collection("UserName")
                                        .where("Email",
                                            isEqualTo:
                                                emailController.text.trim())
                                        .get()
                                        .then((value) {
                                      if (value.size != 0) {
                                        value.docs.forEach((element) async {
                                          print(
                                              'nnn mobile num ${element.data()['Email']}');
                                          email = element
                                              .data()['Email']
                                              .toString();
                                        });

                                        Future.delayed(
                                            const Duration(milliseconds: 700),
                                            () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: email!,
                                                    password: passwordController
                                                        .text
                                                        .trim())
                                                .whenComplete(() async {
                                              FirebaseAuth.instance.currentUser
                                                  ?.reload();
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                context.vxNav.push(Uri(
                                                    path: MyRoutes.homeRoute));
                                              }
                                            });
                                          } catch (e) {
                                            ShowErrorDialog(context, e);
                                            throw Exception(e);
                                          }
                                        });
                                      } else {
                                        ShowErrorDialogNormal(context,
                                            'Email Not Matching With Records');
                                      }
                                    });
                                  } else if (emailController.text.isNotEmpty) {
                                    print(
                                        'nnn which UserName Slot ${emailController.text}');
                                    FirebaseFirestore.instance
                                        .collection("UserName")
                                        .where("UserName",
                                            isEqualTo:
                                                emailController.text.trim())
                                        .get()
                                        .then((value) {
                                      if (value.size != 0) {
                                        value.docs.forEach((element) async {
                                          email = element
                                              .data()['Email']
                                              .toString();
                                        });

                                        Future.delayed(
                                            const Duration(milliseconds: 700),
                                            () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: email!,
                                                    password: passwordController
                                                        .text
                                                        .trim())
                                                .whenComplete(() async {
                                              FirebaseAuth.instance.currentUser
                                                  ?.reload();
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                Navigator.pop(context);
                                                context.vxNav.push(Uri(
                                                    path: MyRoutes.homeRoute));
                                              }
                                            });
                                          } catch (e) {
                                            ShowErrorDialog(context, e);
                                          }
                                        });
                                      } else {
                                        ShowErrorDialogNormal(context,
                                            'UserName Not Matching With Records');
                                      }
                                    });
                                  }
                                }
                              },
                              child: Text('Sign in')),
                          SizedBox(height: context.screenWidth * 0.003),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          color: Colors.grey.shade50,
                                          width: context.screenWidth * 0.5,
                                          height: context.screenHeight * 0.3,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.close)),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    "Please Enter Email to Reset Password"
                                                        .text
                                                        .semiBold
                                                        .xl
                                                        .make(),
                                                    SizedBox(
                                                        height: context
                                                                .screenHeight *
                                                            0.03),
                                                    TextField(
                                                      controller:
                                                          forgotPasswordController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter Your Email.'),
                                                    )
                                                        .box
                                                        .width(context
                                                                .screenWidth *
                                                            0.3)
                                                        .make(),
                                                    SizedBox(
                                                        height: context
                                                                .screenHeight *
                                                            0.03),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          if (RegExp(
                                                                  r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                                                  caseSensitive:
                                                                      false)
                                                              .hasMatch(
                                                                  forgotPasswordController
                                                                      .text
                                                                      .trim())) {
                                                            FirebaseAuth
                                                                .instance
                                                                .sendPasswordResetEmail(
                                                                    email: forgotPasswordController
                                                                        .text
                                                                        .trim())
                                                                .then((value) =>
                                                                    Navigator.pop(
                                                                        context));
                                                          } else {
                                                            ShowErrorDialogNormal(
                                                                ctx,
                                                                'Please Check Your Email');
                                                          }
                                                        },
                                                        child: Text(
                                                            'Reset Password'))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child:
                                  Text('Forget Password').text.semiBold.make())
                        ],
                      )
                          .box
                          .alignCenter
                          .margin(EdgeInsets.only(
                            left: context.screenWidth * 0.275,
                          ))
                          .width(context.screenWidth * 0.35)
                          .height(context.screenHeight * 0.625)
                          .make(),
                    ),
                  ],
                )
                    .box
                    .width(context.screenWidth * 0.7)
                    .height(context.screenHeight * 0.7)
                    .make(),
              ),
            ),
          );
        });
  }

  void signupFunc(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          TextEditingController firstNameController = TextEditingController();
          TextEditingController lastNameController = TextEditingController();
          TextEditingController userNameController = TextEditingController();
          TextEditingController emailController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          TextEditingController reEnterPasswordController =
              TextEditingController();
          TextEditingController mobileNumberController =
              TextEditingController();
          TextEditingController countryCodeController = TextEditingController();
          TextEditingController countryNameController = TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          bool acceptance = false;

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ShowHideSignupPasswordCubit()),
              BlocProvider(create: (context) => PassVerificationIdCubit()),
              BlocProvider(create: (context) => GoToMpinCubit()),
              BlocProvider(create: (context) => AgreeTermsConditionsCubit()),
              BlocProvider(
                  create: (context) => ShowCountryCodeAtSignupUiCubit()),
              BlocProvider(
                  create: (context) => ShowHideSignupReenterPasswordCubit()),
            ],
            child: Dialog(child: BlocBuilder<GoToMpinCubit, GoToMpinState>(
              builder: (context, mPinState) {
                if (mPinState.task == 1) {
                  print(
                      'nnn mobile Number ${countryCodeController.text.trim()}${mobileNumberController.text.trim()}');
                  FirebaseAuth.instance
                      .signInWithPhoneNumber(
                          '${countryCodeController.text.trim()}${mobileNumberController.text.trim()}')
                      .then((value) {
                    print('nnn verification id ${value.verificationId}');
                    context
                        .read<PassVerificationIdCubit>()
                        .listenForVerificationId(value.verificationId);
                  });
                } else if (mPinState.task == 2) {
                  FirebaseAuth.instance.authStateChanges().listen((event) {
                    if (event != null) {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    }
                  });
                }
                return BlocBuilder<PassVerificationIdCubit,
                    PassVerificationIdState>(
                  builder: (context, verificationIdState) {
                    return Container(
                        width: context.screenWidth * 0.8,
                        height: context.screenHeight * 0.8,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: context.screenWidth * 0.3,
                                height: context.screenHeight * 0.81,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/images/signupBg.jpeg"))),
                              ),
                            ),
                            /*  Positioned(
                              left: 0,
                              top: context.screenHeight * 0.075,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                          'assets/images/Happybunchastronaut.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Wonderlearnersartclass.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Yuppiessuperidea.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                ],
                              )
                                  .box
                                  .width(context.screenWidth * 0.1)
                                  .height(context.screenHeight * 0.55)
                                  .make(),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                          'assets/images/Stuckathomestatsandgraphs.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.225)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Brazucabrowsing.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.225)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Dayflowbestfriends.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.225)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset('assets/images/Cittpartytime.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.225)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Olgardeningtogether.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.225)
                                      .height(context.screenHeight * 0.15)
                                      .make()
                                ],
                              )
                                  .box
                                  .width(context.screenWidth * 0.8)
                                  .height(context.screenHeight * 0.25)
                                  .make(),
                            ),
                            Positioned(
                              right: 0,
                              top: context.screenHeight * 0.075,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/images/Thebandband.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Hobbieshobbiesfill.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                  Image.asset(
                                          'assets/images/Shopaholicsseller.png',
                                          fit: BoxFit.fill)
                                      .box
                                      .width(context.screenHeight * 0.2)
                                      .height(context.screenHeight * 0.15)
                                      .make(),
                                ],
                              )
                                  .box
                                  .width(context.screenWidth * 0.1)
                                  .height(context.screenHeight * 0.55)
                                  .make(),
                            ),
                            */
                            Align(
                              alignment: Alignment.bottomRight,
                              /* left: context.screenWidth * 0.1,
                              bottom: context.screenHeight * 0.1, */
                              child: mPinState.task == 0
                                  ? Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          "Welcome To Biggest Articles Hub"
                                              .text
                                              .xl3
                                              .semiBold
                                              .make()
                                              .box
                                              .margin(EdgeInsets.only(left: 20))
                                              .make(),
                                          SignupRowTextField(
                                              context: context,
                                              hintText1: 'First Name',
                                              hintText2: 'Last Name',
                                              validator1: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Enter a Valid Name';
                                                }
                                              },
                                              validator2: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Enter a Valid Name';
                                                }
                                              },
                                              textEditingController1:
                                                  firstNameController,
                                              textEditingController2:
                                                  lastNameController),
                                          /*     SizedBox(
                                              height:
                                                  context.screenHeight * 0.01), */
                                          SignupRowTextField(
                                              context: context,
                                              hintText1: 'User Name',
                                              hintText2: 'Email',
                                              validator1: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Enter a Valid Name';
                                                }
                                              },
                                              validator2: (val) {
                                                if (!RegExp(
                                                        r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                                        caseSensitive: false)
                                                    .hasMatch(val!)) {
                                                  return 'Enter a Valid Email';
                                                }
                                              },
                                              textEditingController1:
                                                  userNameController,
                                              textEditingController2:
                                                  emailController),
                                          /* SizedBox(
                                              height:
                                                  context.screenHeight * 0.01), */
                                          SignupRowPasswordTextField(
                                              context: context,
                                              hintText1: 'Password',
                                              hintText2: 'Re-Enter Password',
                                              validator1: (val) {
                                                if (!RegExp(
                                                        r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                                                    .hasMatch(val!)) {
                                                  return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                                                }
                                              },
                                              validator2: (val) {
                                                if (!RegExp(
                                                        r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                                                    .hasMatch(val!)) {
                                                  return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                                                }
                                              },
                                              textEditingController1:
                                                  passwordController,
                                              textEditingController2:
                                                  reEnterPasswordController),
                                          /*   SizedBox(
                                              height:
                                                  context.screenHeight * 0.01), */
                                          BlocBuilder<
                                                  ShowCountryCodeAtSignupUiCubit,
                                                  ShowCountryCodeAtSignupUiState>(
                                            builder: (context,
                                                countryCodeAtUiState) {
                                              countryCodeController.text =
                                                  countryCodeAtUiState.code;
                                              countryNameController.text =
                                                  countryCodeAtUiState.country;
                                              return TextFormField(
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return 'Enter 10 Digit Mobile Number';
                                                  } else if (val.length != 10) {
                                                    return 'Enter 10 Digit Mobile Number';
                                                  }
                                                },
                                                controller:
                                                    mobileNumberController,
                                                textAlign: TextAlign.left,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    prefix: TextButton(
                                                      onPressed: () {
                                                        getSelectedCountryDetails(
                                                            String name,
                                                            String code) {
                                                          print(
                                                              'nnn names Codes  ');
                                                          context
                                                              .read<
                                                                  ShowCountryCodeAtSignupUiCubit>()
                                                              .listenForCountryCode(
                                                                  code, name);
                                                          countryNameController
                                                              .text = name;
                                                          countryCodeController
                                                              .text = code;
                                                        }

                                                        showCountryDialog(
                                                            context,
                                                            getSelectedCountryDetails,
                                                            countryNameController
                                                                .text,
                                                            countryCodeController
                                                                .text);
                                                      },
                                                      child: Text(
                                                          countryCodeAtUiState
                                                              .code),
                                                    ),
                                                    hintText: 'Mobile Number',
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(context
                                                                    .screenHeight *
                                                                0.015))),
                                              );
                                            },
                                          )
                                              .box
                                              .padding(EdgeInsets.only(
                                                  left: context.screenWidth *
                                                      0.0175))
                                              .width(
                                                  context.screenWidth * 0.2425)
                                              .height(
                                                  context.screenHeight * 0.1)
                                              .make(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              BlocBuilder<
                                                  AgreeTermsConditionsCubit,
                                                  AgreeTermsConditionsState>(
                                                builder: (context,
                                                    agreeTermsConditionState) {
                                                  acceptance =
                                                      agreeTermsConditionState
                                                          .agree;
                                                  return agreeTermsConditionState
                                                          .agree
                                                      ? IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    AgreeTermsConditionsCubit>()
                                                                .listenForAcceptance(
                                                                    !agreeTermsConditionState
                                                                        .agree);
                                                          },
                                                          icon: Icon(
                                                              Icons.check_box))
                                                      : IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    AgreeTermsConditionsCubit>()
                                                                .listenForAcceptance(
                                                                    !agreeTermsConditionState
                                                                        .agree);
                                                          },
                                                          icon: Icon(Icons
                                                              .check_box_outline_blank));
                                                },
                                              ),
                                              TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                actions: [
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        'Terms & Condition',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      )
                                                                          .box
                                                                          .alignCenterLeft
                                                                          .width(context.screenWidth *
                                                                              0.45)
                                                                          .make(),
                                                                      SizedBox(
                                                                          height:
                                                                              context.screenHeight * 0.015),
                                                                      Text(userTerms)
                                                                          .box
                                                                          .alignCenterLeft
                                                                          .width(context.screenWidth *
                                                                              0.45)
                                                                          .make(),
                                                                      SizedBox(
                                                                          height:
                                                                              context.screenHeight * 0.015),
                                                                      TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text('Close'))
                                                                          .box
                                                                          .alignCenterRight
                                                                          .width(context.screenWidth * 0.45)
                                                                          .make(),
                                                                    ],
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: Text(
                                                          'Terms & Conditions'))
                                                  .box
                                                  .padding(EdgeInsets.only(
                                                      left:
                                                          context.screenWidth *
                                                              0.01))
                                                  .make(),
                                            ],
                                          )
                                              .box
                                              .height(
                                                  context.screenHeight * 0.065)
                                              .width(context.screenWidth)
                                              .padding(EdgeInsets.only(
                                                  left: context.screenWidth *
                                                      0.01))
                                              .make(),
                                          ElevatedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();

                                                      if (acceptance) {
                                                        if (passwordController
                                                                .text ==
                                                            reEnterPasswordController
                                                                .text) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'UserName')
                                                              .where('UserName',
                                                                  isEqualTo:
                                                                      userNameController
                                                                          .text
                                                                          .trim())
                                                              .get()
                                                              .then((value) {
                                                            if (value.size !=
                                                                0) {
                                                              ShowErrorDialogNormal(
                                                                  context,
                                                                  'UserName Already Exist');
                                                            } else {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'UserName')
                                                                  .where(
                                                                      'Email',
                                                                      isEqualTo: emailController
                                                                          .text
                                                                          .trim())
                                                                  .get()
                                                                  .then((val) {
                                                                if (val.size !=
                                                                    0) {
                                                                  ShowErrorDialogNormal(
                                                                      context,
                                                                      'Email Already Exist');
                                                                } else {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'UserName')
                                                                      .where(
                                                                          'MobileNumber',
                                                                          isEqualTo: mobileNumberController
                                                                              .text
                                                                              .trim())
                                                                      .get()
                                                                      .then(
                                                                          (v) {
                                                                    if (v.size !=
                                                                        0) {
                                                                      ShowErrorDialogNormal(
                                                                          context,
                                                                          'MobileNumber Already Exist');
                                                                    } else {
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .createUserWithEmailAndPassword(
                                                                              email: emailController.text.trim(),
                                                                              password: passwordController.text.trim())
                                                                          .then((usr) {
                                                                        if (usr.user !=
                                                                            null) {
                                                                          String uid = FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid;
                                                                          SignUpDataModel userProfileData = SignUpDataModel(
                                                                              notificationToken:
                                                                                  '',
                                                                              role:
                                                                                  'User',
                                                                              firstName: firstNameController.text
                                                                                  .trim(),
                                                                              lastName: lastNameController.text
                                                                                  .trim(),
                                                                              email: emailController.text
                                                                                  .trim(),
                                                                              disableTill:
                                                                                  null,
                                                                              countryCode: countryCodeController.text
                                                                                  .trim(),
                                                                              countryName: countryNameController.text
                                                                                  .trim(),
                                                                              isDisable:
                                                                                  'False',
                                                                              noOfArticlesPostedByAuthor:
                                                                                  0,
                                                                              authorPermissionRequest:
                                                                                  "False",
                                                                              mobileNumber: mobileNumberController.text
                                                                                  .trim(),
                                                                              name:
                                                                                  '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                                                                              isMobileNumberVerified:
                                                                                  'Verified',
                                                                              userName: userNameController.text
                                                                                  .trim(),
                                                                              userFavouriteArticle: [
                                                                                "Social Issues"
                                                                              ],
                                                                              photoUrl:
                                                                                  'images/fluenzologo.png',
                                                                              userCountryPreferences: [
                                                                                'All',
                                                                                countryNameController.text.trim()
                                                                              ],
                                                                              userUID: uid);
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  'GeneralAppUserNotificationToken')
                                                                              .doc(
                                                                                  uid)
                                                                              .set({
                                                                            'NotificationToken':
                                                                                ''
                                                                          });

                                                                          SignupDataBase().createUserProfile(
                                                                              uid,
                                                                              userProfileData.toJson());

                                                                          SignupDataBase().createUserNameColl(
                                                                              uid,
                                                                              emailController.text.trim(),
                                                                              userNameController.text.trim(),
                                                                              mobileNumberController.text.trim());
                                                                          SharedPreferences.getInstance()
                                                                              .then((val) {
                                                                            FavArticleSharedPreferences().setFavCategories([
                                                                              "Social Issues"
                                                                            ], val);
                                                                          });
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .sendEmailVerification();
                                                                          context
                                                                              .read<GoToMpinCubit>()
                                                                              .listenForTask(2);
                                                                        }
                                                                      });

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
                                                          ShowErrorDialogNormal(
                                                              context,
                                                              'Please Check Password Entered');
                                                        }
                                                      } else {
                                                        ShowErrorDialogNormal(
                                                            context,
                                                            'Please Check Terms & Conditions');
                                                      }
                                                    }
                                                  },
                                                  child: Text('Sign Up'))
                                              .box
                                              .alignCenter
                                              .make()
                                        ],
                                      )
                                          .box
                                          .height(context.screenHeight * 0.725)
                                          .width(context.screenWidth * 0.5)
                                          .make(),
                                    )
                                  : mPinState.task == 1
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: context.screenWidth * 0.5,
                                          height: context.screenHeight * 0.45,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              "Please Enter OTP Here"
                                                  .text
                                                  .semiBold
                                                  .xl2
                                                  .make(),
                                              SizedBox(
                                                  height: context.screenHeight *
                                                      0.05),
                                              PinCodeTextField(
                                                autofocus: true,
                                                controller: controller,
                                                hideCharacter: false,
                                                highlight: true,
                                                highlightColor: Colors.blue,
                                                defaultBorderColor:
                                                    Colors.black,
                                                hasTextBorderColor:
                                                    Colors.green,
                                                maxLength: 6,
                                                onTextChanged: (text) {},
                                                onDone: (getMpin) async {
                                                  try {
                                                    print(
                                                        'nnn getMoin $getMpin');
                                                    await FirebaseAuth.instance
                                                        .signInWithCredential(
                                                            PhoneAuthProvider.credential(
                                                                verificationId:
                                                                    verificationIdState
                                                                            .veridicationId ??
                                                                        'journz',
                                                                smsCode:
                                                                    getMpin))
                                                        .then((value) async {
                                                      if (value.user != null) {
                                                        value.user!.reload();

                                                        SharedPreferences
                                                                .getInstance()
                                                            .then((val) async {
                                                          AuthCredential cred =
                                                              EmailAuthProvider.credential(
                                                                  email:
                                                                      emailController
                                                                          .text
                                                                          .trim(),
                                                                  password:
                                                                      passwordController
                                                                          .text
                                                                          .trim());

                                                          value.user!
                                                              .linkWithCredential(
                                                                  cred)
                                                              .then((value) {
                                                            String uid =
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid;
                                                            SignUpDataModel userProfileData = SignUpDataModel(
                                                                notificationToken:
                                                                    '',
                                                                role: 'User',
                                                                firstName: firstNameController.text
                                                                    .trim(),
                                                                lastName:
                                                                    lastNameController.text
                                                                        .trim(),
                                                                email: emailController
                                                                    .text
                                                                    .trim(),
                                                                disableTill:
                                                                    null,
                                                                countryCode:
                                                                    countryCodeController
                                                                        .text
                                                                        .trim(),
                                                                countryName:
                                                                    countryNameController
                                                                        .text
                                                                        .trim(),
                                                                isDisable:
                                                                    'False',
                                                                noOfArticlesPostedByAuthor:
                                                                    0,
                                                                authorPermissionRequest:
                                                                    "False",
                                                                mobileNumber:
                                                                    mobileNumberController
                                                                        .text
                                                                        .trim(),
                                                                name:
                                                                    '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                                                                isMobileNumberVerified:
                                                                    'Verified',
                                                                userName:
                                                                    userNameController
                                                                        .text
                                                                        .trim(),
                                                                userFavouriteArticle: [
                                                                  "Social Issues"
                                                                ],
                                                                photoUrl:
                                                                    'images/fluenzologo.png',
                                                                userCountryPreferences: [
                                                                  'All',
                                                                  countryNameController
                                                                      .text
                                                                      .trim()
                                                                ],
                                                                userUID: uid);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'GeneralAppUserNotificationToken')
                                                                .doc(uid)
                                                                .set({
                                                              'NotificationToken':
                                                                  ''
                                                            });

                                                            SignupDataBase()
                                                                .createUserProfile(
                                                                    uid,
                                                                    userProfileData
                                                                        .toJson());

                                                            SignupDataBase().createUserNameColl(
                                                                uid,
                                                                emailController
                                                                    .text
                                                                    .trim(),
                                                                userNameController
                                                                    .text
                                                                    .trim(),
                                                                mobileNumberController
                                                                    .text
                                                                    .trim());

                                                            FavArticleSharedPreferences()
                                                                .setFavCategories(
                                                                    [
                                                                  "Social Issues"
                                                                ],
                                                                    val);
                                                            context
                                                                .read<
                                                                    GoToMpinCubit>()
                                                                .listenForTask(
                                                                    2);
                                                          });
                                                        });
                                                      }
                                                    });
                                                  } catch (e) {
                                                    ShowErrorDialog(context, e);
                                                  }
                                                },
                                                pinBoxWidth:
                                                    context.screenWidth * 0.03,
                                                pinBoxHeight:
                                                    context.screenWidth * 0.035,
                                                hasUnderline: true,
                                                wrapAlignment:
                                                    WrapAlignment.spaceAround,
                                                pinBoxDecoration:
                                                    ProvidedPinBoxDecoration
                                                        .defaultPinBoxDecoration,
                                                pinTextStyle:
                                                    TextStyle(fontSize: 22.0),
                                                pinTextAnimatedSwitcherTransition:
                                                    ProvidedPinBoxTextAnimation
                                                        .scalingTransition,
                                                pinTextAnimatedSwitcherDuration:
                                                    Duration(milliseconds: 300),
                                                highlightAnimationBeginColor:
                                                    Colors.black12,
                                                highlightAnimationEndColor:
                                                    Colors.white12,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: context.screenWidth * 0.5,
                                          height: context.screenHeight * 0.435,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                        'assets/images/verifyEmail.png')
                                                    .box
                                                    .width(context.screenWidth *
                                                        0.35)
                                                    .height(
                                                        context.screenHeight *
                                                            0.3)
                                                    .make(),
                                                SizedBox(
                                                  height: context.screenHeight *
                                                      0.015,
                                                ),
                                                "A verification Email Sent To Your Registered Email. Please Verify It"
                                                    .text
                                                    .semiBold
                                                    .xl3
                                                    .center
                                                    .make()
                                                    .box
                                                    .width(context.screenWidth *
                                                        0.45)
                                                    .height(
                                                        context.screenHeight *
                                                            0.1)
                                                    .make(),
                                              ]),
                                        ),
                            )
                          ],
                        ));
                  },
                );
              },
            )),
          );
        });
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
                          SizedBox(height: context.screenHeight * 0.03),
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
                              .width(context.screenWidth * 0.3)
                              .height(context.screenHeight * 0.6)
                              .make(),
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(context.screenHeight * 0.01))
                          .width(context.screenWidth * 0.3)
                          .height(context.screenHeight * 0.75)
                          .make(),
                    );
                  },
                );
              },
            ),
          );
        });
  }

  Widget SignupRowTextField(
      {required BuildContext context,
      required String hintText1,
      required String hintText2,
      String? Function(String?)? validator1,
      String? Function(String?)? validator2,
      required TextEditingController textEditingController1,
      required TextEditingController textEditingController2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          validator: validator1,
          controller: textEditingController1,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintText: hintText1,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(context.screenHeight * 0.015))),
        )
            .box
            .width(context.screenWidth * 0.225)
            .height(context.screenHeight * 1)
            .make(),
        TextFormField(
          validator: validator2,
          controller: textEditingController2,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintText: hintText2,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(context.screenHeight * 0.015))),
        )
            .box
            .width(context.screenWidth * 0.225)
            .height(context.screenHeight * 1)
            .make(),
      ],
    ).box.width(context.screenWidth).height(context.screenHeight * 0.1).make();
  }

  Widget SignupRowPasswordTextField(
      {required BuildContext context,
      required String hintText1,
      required String hintText2,
      String? Function(String?)? validator1,
      String? Function(String?)? validator2,
      required TextEditingController textEditingController1,
      required TextEditingController textEditingController2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<ShowHideSignupPasswordCubit, ShowHideSignupPasswordState>(
          builder: (context, passwordState) {
            return TextFormField(
              validator: validator1,
              controller: textEditingController1,
              textAlign: TextAlign.left,
              obscureText: passwordState.isPasswordEnabled,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<ShowHideSignupPasswordCubit>()
                            .listenChange(!passwordState.isPasswordEnabled);
                      },
                      icon: passwordState.isPasswordEnabled
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  hintText: hintText1,
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(context.screenHeight * 0.015))),
            );
          },
        )
            .box
            .width(context.screenWidth * 0.225)
            .height(context.screenHeight * 1)
            .make(),
        BlocBuilder<ShowHideSignupReenterPasswordCubit,
                ShowHideSignupReenterPasswordState>(
          builder: (context, reEnterPasswordState) {
            return TextFormField(
              validator: validator2,
              controller: textEditingController2,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              obscureText: reEnterPasswordState.isReEnterPasswordEnabled,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<ShowHideSignupReenterPasswordCubit>()
                            .listenChange(
                                !reEnterPasswordState.isReEnterPasswordEnabled);
                      },
                      icon: reEnterPasswordState.isReEnterPasswordEnabled
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  hintText: hintText2,
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(context.screenHeight * 0.015))),
            );
          },
        )
            .box
            .width(context.screenWidth * 0.225)
            .height(context.screenHeight * 1)
            .make(),
      ],
    ).box.width(context.screenWidth).height(context.screenHeight * 0.1).make();
  }
}
