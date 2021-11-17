import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journz_web/NewDesign/panes/centerpane.dart';
import 'package:journz_web/NewDesign/panes/left.dart';
import 'package:universal_html/js.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: context.isMobile
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                //leading: Image.asset("assets/images/newlogo.png"),
                title: Image.asset(
                  "assets/images/newlogo.png",
                  height: 100,
                ),
                centerTitle: false,
                actions: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //"Hello".text.xl.black.make(),
                      10.widthBox,
                      Container(
                          height: 50,
                          width: 200,
                          child: CupertinoSearchTextField(
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F8F9),
                                borderRadius: BorderRadius.circular(15)),
                        )),
                    ],
                  ).pOnly(right: 40, top: 12, bottom: 12)
                ],
              )
            : AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                //toolbarHeight: 50,
                title: Image.asset(
                  "assets/images/newlogo.png",
                  height: 100,
                ),
                centerTitle: false,

                actions: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //"Hello".text.xl.black.make(),
                      10.widthBox,
                      Container(
                          height: 50,
                          width: 300,
                          child: CupertinoSearchTextField(
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F8F9),
                                borderRadius: BorderRadius.circular(30)),
                          )),
                    ],
                  ).pOnly(right: 540, top: 12, bottom: 12)
                  // Container(width: 300, height: 20, child: CupertinoSearchTextField())
                  //     .p12()
                ],
              ),
        body: SingleChildScrollView(
          child: context.isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 10.heightBox,
                    // CupertinoSearchTextField().p16(),
                    // 18.heightBox,
                    CenterPane()
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          //flex: 1,
                          child: Container(
                            height: context.screenHeight,
                            //width: context.percentWidth * 26,
                            child: Left(),
                            //color: Colors.red,
                          ),
                        ),
                        Container(
                          height: context.screenHeight,
                          width: 825,
                          child: CenterPane(),
                          //width: context.percentWidth * 66,
                          //color: Colors.blue,
                        ),
                        Flexible(
                          //flex: 1,
                          child: Container(
                            height: context.screenHeight,
                            //color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
        ));
  }
}
