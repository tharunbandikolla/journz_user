import 'package:journz_web/homePage/newhomepage.dart';
import 'package:journz_web/utils/routes.dart';

import '/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/AuthenticationBloc/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Authentication/AuthenticationBloc/SignUpCubit/signup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Authentication/AuthenticationBloc/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import '/Authentication/Screens/NewLoginScreen.dart';
import '/Authentication/Screens/NewSignupScreen.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Widgets/NewCircularElevattedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class InitialAccountSelection extends StatelessWidget {
  const InitialAccountSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.40), BlendMode.darken),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/AuthenticationBG.jpg'))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/journzpng2.png')
                    .box
                    .width(40)
                    .height(40)
                    // .width(context.screenWidth * 0.15)
                    // .height(context.screenWidth * 0.15)
                    .makeCentered(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "JOURNZ"
                        .text
                        .white
                        .xl4
                        .bold
                        //.letterSpacing(context.screenWidth * 0.045)
                        .make(),
                    10.heightBox,
                    "Journal of Your Lifetime Journey"
                        .text
                        .white
                        .lg
                        .tight
                        .align(TextAlign.right)
                        .bold
                        .make(),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            //alignment: Alignment.center,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewCircularElevattedButton(
                  name: 'Sign in',
                  func: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          ShowhidepasswordCubit()),
                                  BlocProvider(
                                      create: (context) => LoginCubit())
                                ], child: NewLoginScreen())));
                  },
                  padHorizontal: 40,
                  padVertical: 20,
                  fontSize: 15,
                ),
                10.heightBox,
                //SizedBox(height: context.screenWidth * 0.1),
                NewCircularElevattedButton(
                  name: 'Sign Up',
                  func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider(
                              create: (context) => SignupcheckboxCubit()),
                          BlocProvider(
                              create: (context) => LoadingscreenCubit()),
                          BlocProvider(create: (context) => SignupCubit()),
                          BlocProvider(
                              create: (context) =>
                                  ShowhidepasswordinsignupCubit()),
                          BlocProvider(
                              create: (context) =>
                                  ShowHideReEnterPasswordCubit()),
                          BlocProvider(create: (context) => SignupBloc())
                        ], child: NewSignupScreen()),
                      ),
                    );
                  },
                  padHorizontal: 40,
                  padVertical: 20,
                  fontSize: 15,
                ),
                10.heightBox,
                //SizedBox(height: context.screenWidth * 0.035),
                InkWell(
                        onTap: () {
                          FirebaseAuth.instance
                              .signInAnonymously()
                              .then((value) {
                            if (value.user != null) {
                              context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomePage()));
                            }
                          });
                        },
                        child: "Continue as a Guest"
                            .text
                            .white
                            .bold
                            .xl
                            .makeCentered())
                    .box
                    .width(150)
                    .height(40)
                    .makeCentered(),
              ],
            ),
          ),
        )
      ],
    )
        // Container(
        // alignment: Alignment.center,
        // width: context.screenWidth,
        // height: context.screenHeight,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         colorFilter: ColorFilter.mode(
        //             Colors.white.withOpacity(0.75), BlendMode.dstATop),
        //         fit: BoxFit.cover,
        //         image: AssetImage('assets/images/AuthenticationBG.jpg'))),
        //     child: Column(
        //       children: [
        //         SizedBox(height: context.screenWidth * 0.45),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Image.asset('assets/images/journzpng2.png')
        //                 .box
        //                 .width(context.screenWidth * 0.15)
        //                 .height(context.screenWidth * 0.15)
        //                 .makeCentered(),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 "JOURNZ"
        //                     .text
        //                     .white
        //                     .xl4
        //                     .bold
        //                     .letterSpacing(context.screenWidth * 0.045)
        //                     .make(),
        //                 "Journal of Your Lifetime Journey"
        //                     .text
        //                     .white
        //                     .lg
        //                     .tight
        //                     .align(TextAlign.right)
        //                     .bold
        //                     .make(),
        //               ],
        //             )
        //           ],
        //         )
        //             .box
        //             .width(context.screenWidth * 0.8)
        //             .height(context.screenWidth * 0.175)
        //             .makeCentered(),
        //         SizedBox(height: context.screenWidth * 0.4),
        //         NewCircularElevattedButton(
        //           name: 'Sign in',
        //           func: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => MultiBlocProvider(providers: [
        //                           BlocProvider(
        //                               create: (context) =>
        //                                   ShowhidepasswordCubit()),
        //                           BlocProvider(
        //                               create: (context) => LoginCubit())
        //                         ], child: NewLoginScreen())));
        //           },
        //           padHorizontal: context.screenWidth * 0.25,
        //           padVertical: context.screenWidth * 0.035,
        //           fontSize: context.screenWidth * 0.07,
        //         ),
        //         SizedBox(height: context.screenWidth * 0.1),
        //         NewCircularElevattedButton(
        //           name: 'Sign Up',
        //           func: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => MultiBlocProvider(providers: [
        //                   BlocProvider(
        //                       create: (context) => SignupcheckboxCubit()),
        //                   BlocProvider(
        //                       create: (context) => LoadingscreenCubit()),
        //                   BlocProvider(create: (context) => SignupCubit()),
        //                   BlocProvider(
        //                       create: (context) =>
        //                           ShowhidepasswordinsignupCubit()),
        //                   BlocProvider(
        //                       create: (context) =>
        //                           ShowHideReEnterPasswordCubit()),
        //                   BlocProvider(create: (context) => SignupBloc())
        //                 ], child: NewSignupScreen()),
        //               ),
        //             );
        //           },
        //           padHorizontal: context.screenWidth * 0.23,
        //           padVertical: context.screenWidth * 0.035,
        //           fontSize: context.screenWidth * 0.07,
        //         ),
        //         SizedBox(height: context.screenWidth * 0.035),
        //         InkWell(
        //                 onTap: () {
        //                   FirebaseAuth.instance
        //                       .signInAnonymously()
        //                       .then((value) {
        //                     if (value.user != null) {
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) => HomePage()));
        //                     }
        //                   });
        //                 },
        //                 child: "Continue as a Guest"
        //                     .text
        //                     .white
        //                     .bold
        //                     .xl
        //                     .makeCentered())
        //             .box
        //             .width(context.screenWidth * 0.65)
        //             .height(context.screenWidth * 0.1)
        //             .makeCentered(),
        //       ],
        //     ))
        );
  }
}
