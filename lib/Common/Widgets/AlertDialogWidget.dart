import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowAlertDialog extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;

  ShowAlertDialog(
      {Key? key,

      //  required this.ctx,
      required this.alertType,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        title: Center(child: Text(alertType).text.underline.make()),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          height: getWidth(context) * 1.5,
          width: getWidth(context),
          child: Column(
            children: [
              15.heightBox,
              Container(
                height: getWidth(context) * 1.25,
                width: getWidth(context),
                child: SingleChildScrollView(
                  child: Text(userTerms),
                ),
              ),
              10.heightBox,
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay')))
            ],
          ),
        ));
  }
}

class ShowAuthorAlertDialog extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;
  String? role;
  String? decisionText;

  ShowAuthorAlertDialog(
      {Key? key,
      this.decisionText,
      //  required this.ctx,
      required this.alertType,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        title: Center(
            child: Text(
                    decisionText == "False" ? alertType : "Author Request Done")
                .text
                .underline
                .make()),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          height: decisionText == "False"
              ? getWidth(context) * 1.5
              : getWidth(context) * 0.5,
          width: getWidth(context),
          child: Column(
            children: [
              15.heightBox,
              Container(
                height: decisionText == "False"
                    ? getWidth(context) * 1.25
                    : getWidth(context) * 0.2,
                width: getWidth(context),
                child: SingleChildScrollView(
                  child: Text(decisionText == 'False'
                          ? userTerms
                          : "You Have Requested For The Author Permission Before. \nPlease Wait For Approval")
                      .text
                      .xl
                      .makeCentered(),
                ),
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  decisionText == "False"
                      ? TextButton(
                          onPressed: () {
                            print('check');
                            Navigator.pop(context);
                          },
                          child: Text('Decline').text.xl.bold.make())
                      : Container(),
                  TextButton(
                      onPressed: () {
                        print('checking data');
                        if (decisionText == "False")
                          FirebaseFirestore.instance
                              .collection('UserProfile')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'RequestAuthor': 'True'});
                        Navigator.pop(context);
                      },
                      child: Text(decisionText == "False" ? 'Accept' : 'Close')
                          .text
                          .xl
                          .bold
                          .make()),
                ],
              )
                  .box
                  .width(context.screenWidth)
                  .height(context.screenHeight * 0.051)
                  .alignCenterRight
                  .make()
            ],
          ),
        ));
  }
}
