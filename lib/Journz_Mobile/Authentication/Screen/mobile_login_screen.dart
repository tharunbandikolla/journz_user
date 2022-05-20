import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Journz_Large_Screen/utils/routes.dart';
import '../Component/mobile_form_field.dart';
import '../Cubits/LoginCubit/login_cubit.dart';
import '../Cubits/LoginScreenPasswordBloc/showhidepassword_cubit.dart';

// ignore: must_be_immutable
class MobileLoginScreen extends StatefulWidget {
  MobileLoginScreen({Key? key}) : super(key: key);

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  loginFunc() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      context.read<LoginCubit>().checkUserLogin(
          context, userNameController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginPassWordVisibilityCubit =
        BlocProvider.of<ShowhidepasswordCubit>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          width: context.screenWidth,
          // height: context.screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.35), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image:
                      const AssetImage('assets/images/AuthenticationBG.jpg'))),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ////SizedBox(height: context.screenWidth * 0.1),
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
                            .xl2
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
                        .box
                        .width(context.screenWidth * 0.75)
                        .height(context.screenWidth * 0.15)
                        .makeCentered(),
                  ],
                )
                    .box
                    .width(context.screenWidth)
                    .height(context.screenWidth * 0.25)
                    .makeCentered(),
                //SizedBox(height: context.screenWidth * 0.25),
                Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      NewTextFormField(
                          readOnly: false,
                          keyBoardType: TextInputType.name,
                          newWidth: context.screenWidth * 1.5,
                          hintText: 'UserName \\ Email \\ Mobile Number',
                          controller: userNameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Email/UserName/Mobile Number';
                            }
                          }),
                      //SizedBox(height: context.screenWidth * 0.05),
                      BlocBuilder<ShowhidepasswordCubit, ShowHidePasswordState>(
                        builder: (context, passwordState) {
                          return TextFormField(
                            controller: passwordController,
                            obscureText: passwordState.showHidePassWord,
                            onFieldSubmitted: (String v) {
                              //loginFunc();
                            },
                            validator: (val) {
                              if (!RegExp(
                                      r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                                  .hasMatch(val!)) {
                                return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                fillColor: Colors.black.withOpacity(0.35),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (passwordState.showHidePassWord) {
                                        loginPassWordVisibilityCubit
                                            .updateShowHidePasswordBool(false);
                                      } else {
                                        loginPassWordVisibilityCubit
                                            .updateShowHidePasswordBool(true);
                                      }
                                    },
                                    icon: passwordState.showHidePassWord
                                        ? Icon(Icons.visibility_off_outlined)
                                        : Icon(Icons.visibility_outlined)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        context.screenWidth * 0.5)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: context.screenWidth * 0.05,
                                    vertical: context.screenWidth * 0.04),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white)),
                          );
                        },
                      ),
                      InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController
                                          forgotPasswordController =
                                          TextEditingController();
                                      return Dialog(
                                        child: Container(
                                          height: context.screenWidth * 0.3,
                                          width: context.screenWidth,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                "Please Enter Your Email Id To Get Password Reset Link"
                                                    .text
                                                    .medium
                                                    .bold
                                                    .make(),
                                                TextField(
                                                  controller:
                                                      forgotPasswordController,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Enter Email Here...",
                                                      border:
                                                          OutlineInputBorder()),
                                                )
                                                    .box
                                                    .width(context.screenWidth *
                                                        0.75)
                                                    .make(),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (forgotPasswordController
                                                              .text
                                                              .isNotBlank &&
                                                          forgotPasswordController
                                                              .text
                                                              .isNotEmpty) {
                                                        if (!RegExp(
                                                                r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                                                caseSensitive:
                                                                    false)
                                                            .hasMatch(
                                                                forgotPasswordController
                                                                    .text
                                                                    .trim())) {
                                                          return null;
                                                        } else {
                                                          FirebaseAuth.instance
                                                              .sendPasswordResetEmail(
                                                                  email:
                                                                      forgotPasswordController
                                                                          .text
                                                                          .trim())
                                                              .then((value) =>
                                                                  context.vxNav
                                                                      .pop())
                                                              .onError((error,
                                                                  stackTrace) {
                                                            //   context.vxNav.pop();
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                content: Text(error
                                                                    .toString()
                                                                    .replaceFirst(
                                                                        RegExp(
                                                                            r'\[(.*?)\]',
                                                                            caseSensitive:
                                                                                false),
                                                                        ''))));
                                                          });
                                                        }
                                                      }
                                                    },
                                                    child: Text("Send Link"))
                                              ]),
                                        ),
                                      );
                                    });
                              },
                              child:
                                  "Forgot Password?".text.white.bold.lg.make())
                          .box
                          .alignCenterRight
                          .width(context.screenWidth * 0.75)
                          .height(context.screenWidth * 0.065)
                          .makeCentered(),
                      //SizedBox(height: context.screenWidth * 0.05),
                      ElevatedButton(
                          onPressed: loginFunc, child: Text("Log in")),
                    ])
                    .box
                    .width(context.screenWidth)
                    .height(context.screenWidth * 0.7)
                    .make(),
                //SizedBox(height: context.screenWidth * 0.05),
                const Divider(
                  thickness: 4,
                  color: Colors.black,
                ),
                InkWell(
                        onTap: () {
                          context.vxNav.push(
                            Uri(
                                path: MyRoutes.homeRoute,
                                queryParameters: {"Page": "/MobileSignUp"}),
                          );
                        },
                        child: "New to Journz? Sign up Here.."
                            .text
                            .white
                            .bold
                            .xl
                            .wordSpacing(context.screenWidth * 0.015)
                            .makeCentered())
                    .box
                    .width(context.screenWidth * 0.75)
                    .height(context.screenWidth * 0.1)
                    .makeCentered(),
              ],
            )
                .box
                .p12
                .width(context.screenWidth)
                .height(context.screenWidth * 2)
                .makeCentered(),
          )),
    ));
  }
}
