import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowHideLoginPasswordCubit/show_hide_login_password_cubit.dart';
import '/Journz_Large_Screen/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldBodyLeftPane extends StatefulWidget {
  const OldBodyLeftPane({Key? key}) : super(key: key);

  @override
  _OldBodyLeftPaneState createState() => _OldBodyLeftPaneState();
}

class _OldBodyLeftPaneState extends State<OldBodyLeftPane> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sHPassWordcubit =
        BlocProvider.of<ShowHideLoginPasswordCubit>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.screenHeight * 0.02),
      width: context.screenWidth * 0.2,
      height: context.screenHeight * 0.865,
//      color: Colors.grey.shade50,
      child: Column(children: [
        BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
          builder: (context, userState) {
            return Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.white,
                        width: context.screenHeight * 0.003),
                    borderRadius:
                        BorderRadius.circular(context.screenHeight * 0.025)),
                elevation: 4,
                child: !userState.isLoggined!
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: context.screenWidth * 0.2,
                        height: context.screenHeight * 0.425,
                        padding: EdgeInsets.symmetric(
                            vertical: context.screenHeight * 0.015,
                            horizontal: context.screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              context.screenHeight * 0.025),
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          children: [
                            "Sign in".text.xl.make(),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            TextField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                )),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            BlocBuilder<ShowHideLoginPasswordCubit,
                                ShowHideLoginPasswordState>(
                              builder: (context, shPasswordstate) {
                                return TextField(
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            sHPassWordcubit.getvisibility(
                                                !shPasswordstate.visibleOff);
                                          },
                                          icon: shPasswordstate.visibleOff
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility))),
                                  obscureText: shPasswordstate.visibleOff,
                                );
                              },
                            ),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.015),
                            ElevatedButton(
                                onPressed: () {
                                  if (emailController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim())
                                        .then((value) => context.vxNav.push(
                                            Uri(path: MyRoutes.homeRoute)))
                                        .onError((error, stackTrace) =>
                                            ScaffoldMessenger.of(context)
                                                .showMaterialBanner(
                                                    MaterialBanner(
                                                        content: Text(error
                                                            .toString()
                                                            .split(']')
                                                            .last),
                                                        actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentMaterialBanner();
                                                    },
                                                    child: Text('Close'),
                                                  )
                                                ])));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(MaterialBanner(
                                            content: Text(
                                                'Please Enter Email And Password'),
                                            actions: [
                                          TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: Text('Close'),
                                          )
                                        ]));
                                  }
                                },
                                child: Text('Sign in')),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            Divider(),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            "Don\'t Have An Acc.!, Register Here".text.make()
                          ],
                        ),
                      )
                    : AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: context.screenWidth * 0.2,
                        height: context.screenHeight * 0.425,
                        padding: EdgeInsets.symmetric(
                            vertical: context.screenHeight * 0.015,
                            horizontal: context.screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              context.screenHeight * 0.025),
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userState.photoUrl! == 'images/fluenzologo.png'
                                ? Container(
                                    width: context.screenWidth * 0.125,
                                    height: context.screenHeight * 0.125,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/journzlogo1.png'),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  )
                                : Container(
                                    width: context.screenWidth * 0.125,
                                    height: context.screenHeight * 0.125,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                userState.photoUrl!),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  ),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: userState.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            Text(
                              userState.email!,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.0125),
                            ElevatedButton(
                                onPressed: () {
                                  context.vxNav
                                      .push(Uri(path: MyRoutes.homeRoute))
                                      .then((value) => FirebaseAuth.instance
                                          .signOut()
                                          .then((value) => ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Signed Out Successfully')))));
                                },
                                child: Text('Sign out'))
                          ],
                        )));
          },
        )
      ]),
    );
  }
}
