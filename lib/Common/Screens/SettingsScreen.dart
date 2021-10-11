import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Widgets/AlertDialogWidget.dart';
import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> fontNames = [
    'Tinos',
    'Montserrat',
    'Playfairdigital',
    'Roboto',
    'Opensans'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appName,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        body: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Column(
            children: [
              FirebaseAuth.instance.currentUser != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('UserProfile')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? Column(
                                children: [
                                  15.heightBox,
                                  HStack(
                                    [
                                      "User Status".text.xl.bold.make(),
                                      "${snapshot.data['Role']}"
                                          .text
                                          .xl
                                          .bold
                                          .make()
                                    ],
                                    alignment: MainAxisAlignment.spaceBetween,
                                  )
                                      .box
                                      //.coolGray400
                                      .width(context.screenWidth * 0.9)
                                      .height(context.screenWidth * 0.05)
                                      .px12
                                      //.alignCenter
                                      .make(),
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      snapshot.data['Role'] == 'User'
                                          ? "Request Author Permission"
                                              .text
                                              .xl
                                              .bold
                                              .make()
                                              .box
                                              .width(context.screenWidth * 0.45)
                                              .height(context.screenWidth * 0.1)
                                              .make()
                                          : Container(),
                                      snapshot.data['Role'] == 'User'
                                          ? ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ShowAuthorAlertDialog(
                                                        decisionText: snapshot
                                                            .data[
                                                                'RequestAuthor']
                                                            .toString(),
                                                        alertType:
                                                            'Terms & Condition',
                                                        alertMessage:
                                                            authorTerms);
                                                  },
                                                );
                                              },
                                              child: snapshot.data['Role'] ==
                                                      'User'
                                                  ? Text(snapshot.data[
                                                              'RequestAuthor'] ==
                                                          'False'
                                                      ? 'Make Request'
                                                      : 'Requested')
                                                  : Text('Content Writer'))
                                          : Container()
                                    ],
                                  )
                                      .box
                                      .width(context.screenWidth * 0.9)
                                      .height(context.screenWidth * 0.2)
                                      .p12
                                      .alignCenter
                                      .make(),
                                ],
                              )
                            : Center(
                                child: Text('Loading...'),
                              );
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Request Author Permission"
                            .text
                            .xl
                            .bold
                            .make()
                            .box
                            .width(context.screenWidth * 0.45)
                            .height(context.screenWidth * 0.1)
                            .make(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserNotLoggedInScreen()));
                            },
                            child: Text('Make Request'))
                      ],
                    )
                      .box
                      .width(context.screenWidth * 0.9)
                      .height(context.screenWidth * 0.2)
                      .p12
                      .alignCenter
                      .make(),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => BlocProvider(
              //                 create: (context) => LoaddatapartbypartCubit(),
              //                 child: CheckScreen(),
              //               )));
//                    for (int i = 2; i <= 300; i++) {
              //                    Future.delayed(Duration(seconds: 1), () {
              //                    FirebaseFirestore.instance.collection('CheckColl').add({
              //                    'Title': 'Title $i',
              //                  'CreatedAt': FieldValue.serverTimestamp()
              //              });
              //          });
              //      }

              /*  FirebaseFirestore.instance
                        .collection('UserProfile')
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection('UserProfile')
                            .doc(element.id)
                            .update(
                                {'IsDisable': 'False', 'DisableTill': null});
                      });
                    });*/
              //},
              // child: Text('set')),
              /* ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('UserProfile')
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        if (element.data()['Role'] == 'Author' ||
                            element.data()['Role'] == 'ContentWriter') {
                          FirebaseFirestore.instance
                              .collection('UserProfile')
                              .doc(element.id)
                              .update({'IsAuthorRequestApproved': 'False'});
                        }
                      });
                    });
                  },
                  child: Text('Update'))*/
            ],
          ),
        ));
  }
}





































































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluenzo/Common/Helper/AuthorRequestCubit/authorrequest_cubit.dart';
// import '/Common/AppTheme/AppTheme.dart';
// import '/Common/AppTheme/ThemeBloc/theme_bloc.dart';
// import '/Common/AppTheme/ThemePreferenses.dart';
// import '/Common/Constant/Constants.dart';
// import '/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
// import '/Common/Widgets/AlertDialogWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   void initState() {
//     if (FirebaseAuth.instance.currentUser != null) {
//       context.read<AuthorrequestCubit>().getRequest();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final preference = BlocProvider.of<SharedprefCubit>(context);
//     preference.getSharedPref();
//     final theme = BlocProvider.of<ThemeBloc>(context);

//     _setTheme(bool darkTheme, SharedPreferences preferences) {
//       AppTheme selectedTheme =
//           darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;

//       theme.add(ThemeEvent(appTheme: selectedTheme));
//       Preferences.saveTheme(selectedTheme, preferences);
//       print('pref theme ${Preferences.getTheme(preferences)}');
//     }

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 12,
// /*        leading: IconButton(
//             icon: Image.asset('images/fluenzologo.png'), onPressed: () {}),*/
//         title: Text(
//           appName,
//           style: Theme.of(context)
//               .textTheme
//               .headline4!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: BlocBuilder<SharedprefCubit, SharedprefState>(
//         builder: (context, state) {
//           print('nnn shared ${state.pref}');
//           return Container(
//             width: getWidth(context),
//             height: getHeight(context),
//             child: Column(
//               children: [
//                 /*   Container(
//                   padding: EdgeInsets.all(getWidth(context) * 0.03),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Change Theme',
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                       Switch(
//                         value: Preferences.getTheme(state.pref) ==
//                             AppTheme.lightTheme,
//                         onChanged: (val) {
//                           print('nnn Theme val ');
//                           print(
//                               'nnn ${Preferences.getTheme(state.pref) == AppTheme.lightTheme}');
//                           _setTheme(val, state.pref);
//                           // if (val) {
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text('Switched To Light Theme')));
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text('Switched To dark Theme')));
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),*/
//                 FirebaseAuth.instance.currentUser != null
//                     ? FutureBuilder(
//                         future: FirebaseFirestore.instance
//                             .collection('UserProfile')
//                             .doc(FirebaseAuth.instance.currentUser!.uid)
//                             .get(),
//                         builder: (context, snapshot) {
//                           return snapshot.hasData
//                               ? Container(
//                                   padding:
//                                       EdgeInsets.all(getWidth(context) * 0.03),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Request Author Permission',
//                                       )
//                                           .text
//                                           .xl
//                                           .make()
//                                           .box
//                                           .width(context.screenWidth * 0.4)
//                                           .height(context.screenWidth * 0.12)
//                                           .make(),
//                                       ElevatedButton(onPressed: () {
//                                         if (FirebaseAuth.instance.currentUser !=
//                                             null) {
//                                           context
//                                               .read<AuthorrequestCubit>()
//                                               .getRequest();
//                                         }

//                                         /* FirebaseFirestore.instance
//                                                 .collection('UserProfile')
//                                                 .doc(FirebaseAuth
//                                                     .instance.currentUser!.uid)
//                                                 .update(
//                                                     {'RequestAuthor': 'True'});*/

//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return BlocBuilder<
//                                                   AuthorrequestCubit,
//                                                   AuthorrequestState>(
//                                                 builder: (context, aState) {
//                                                   return ShowAuthorAlertDialog(
//                                                       decisionText:
//                                                           aState.isRequested,
//                                                       alertType:
//                                                           'Terms & Condition',
//                                                       alertMessage:
//                                                           authorTerms);
//                                                 },
//                                               );
//                                             });
//                                       }, child: BlocBuilder<AuthorrequestCubit,
//                                           AuthorrequestState>(
//                                         builder: (context, aState) {
//                                           return Text(
//                                               aState.isRequested!.trim() ==
//                                                       "True"
//                                                   ? 'Requested'
//                                                   : 'Make Request');
//                                         },
//                                       ))
//                                       /*        Switch(
//                             value: Preferences.getTheme(state.pref) ==
//                                 AppTheme.lightTheme,
//                             onChanged: (val) {
//                               print('nnn Theme val ');
//                               print(
//                                   'nnn ${Preferences.getTheme(state.pref) == AppTheme.lightTheme}');
//                               _setTheme(val, state.pref);
//                               if (val) {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                     content: Text('Switched To Light Theme')));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                     content: Text('Switched To dark Theme')));
//                               }
//                             },
//                           ),*/
//                                     ],
//                                   ),
//                                 )
//                               : Container();
//                         })
//                     : Container(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
