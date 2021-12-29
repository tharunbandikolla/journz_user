import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.vxNav.replace(Uri(path: '/'));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              context.vxNav.popToRoot();
            },
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      scale: .5,
                      matchTextDirection: true,
                      image: AssetImage('assets/images/logo.png'))),
            ),
          ),
          backgroundColor: Colors.grey,
          title: InkWell(
              onTap: () {
                context.vxNav.popToRoot();
              },
              child: "JOURNZ".text.xl4.bold.make()),
        ),
        body: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Contact Us".text.xl6.bold.make(),
              SizedBox(height: context.screenHeight * 0.07),
              """If you have any questions, You can contact us:

By email: team@aamtspn.com

By visiting this page on our website: www.journz.in"""
                  .text
                  .xl2
                  .make()
                  .box
                  .px32
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
