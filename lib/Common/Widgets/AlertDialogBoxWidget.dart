import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowAlertDialogBox extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;

  ShowAlertDialogBox(
      {Key? key,
      //  required this.ctx,
      required this.alertType,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertType),
      content: Text(alertMessage),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Okay', style: Theme.of(context).textTheme.bodyText1))
      ],
    );
  }
}

class ShowAlertNewDarkDialogBox extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;

  ShowAlertNewDarkDialogBox(
      {Key? key,
      //  required this.ctx,
      required this.alertType,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        //     title: Text(alertType),
        content: Container(
            width: context.screenWidth * 0.7,
            height: context.screenHeight * 0.2,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 6.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: [Colors.black38, Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: VStack([
              alertType.text.xl2.bold.white.make().p12(),
              alertMessage.text.xl.white.make().px16(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')
                      .text
                      .bold
                      .lg
                      .white
                      .make()
                      .box
                      .p12
                      .alignBottomRight
                      .make())
            ]))
        //Text(alertMessage),
        //   actions: [
        //   TextButton(
        //     onPressed: () {
        //     Navigator.pop(context);
        //  },
        //child: Text('Okay', style: Theme.of(context).textTheme.bodyText1))
        // ],
        );
  }
}

class ShowAlertNewLightDialogBox extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;

  ShowAlertNewLightDialogBox(
      {Key? key,
      //  required this.ctx,
      required this.alertType,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        //     title: Text(alertType),
        content: Container(
            width: context.screenWidth * 0.7,
            height: context.screenHeight * 0.2,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    //color: Colors.white.withOpacity(0.6),
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 6.0,
                  ),
                  BoxShadow(
                    //color: Colors.white.withOpacity(0.1),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: [Colors.grey[100]!, Colors.grey[100]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: VStack([
              alertType.text.xl2.bold.black.make().p12(),
              alertMessage.text.xl.black.make().px16(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')
                      .text
                      .bold
                      .lg
                      .black
                      .make()
                      .box
                      .p12
                      .alignBottomRight
                      .make())
            ]))
        //Text(alertMessage),
        //   actions: [
        //   TextButton(
        //     onPressed: () {
        //     Navigator.pop(context);
        //  },
        //child: Text('Okay', style: Theme.of(context).textTheme.bodyText1))
        // ],
        );
  }
}

class ShowAlertDialogBoxWithYesNo extends StatelessWidget {
  //BuildContext ctx;
  String alertType;
  String alertMessage;
  VoidCallback accept, decline;

  ShowAlertDialogBoxWithYesNo(
      {Key? key,
      //  required this.ctx,
      required this.alertType,
      required this.accept,
      required this.decline,
      required this.alertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertType),
      content: Text(alertMessage),
      actions: [
        TextButton(
            onPressed: decline,
            child:
                Text('Decline', style: Theme.of(context).textTheme.bodyText1)),
        TextButton(
            onPressed: accept,
            child: Text('Accept', style: Theme.of(context).textTheme.bodyText1))
      ],
    );
  }
}
