import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'privacypolicycontent.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.vxNav.replace(Uri(path: '/home'));
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
          body: VStack([
            title1.text.bold.xl6.make(),
            SizedBox(height: context.screenWidth * 0.025),
            subParagraph1.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.0125),
            title2.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title3.text.bold.xl3.make(),
            SizedBox(height: context.screenWidth * 0.02),
            subParagraph2.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.007),
            title4.text.bold.xl3.make(),
            SizedBox(height: context.screenWidth * 0.007),
            subParagraph3.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title5.text.bold.xl5.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title6.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title7.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.02),
            subParagraph4.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title8.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.02),
            subParagraph5.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title9.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.02),
            subParagraph6.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.02),
            title10.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title11.text.xl2.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subparagraph7.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title12.text.xl2.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph8.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title13.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph9.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title14.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph10.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title15.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title16.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph11.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title17.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph12.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title18.text.bold.xl2.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph13.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title19.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph14.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title20.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph15.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title21.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph16.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title22.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph17.text.xl2.make().box.px32.make(),
            SizedBox(height: context.screenWidth * 0.01),
            title23.text.bold.xl4.make(),
            SizedBox(height: context.screenWidth * 0.01),
            subParagraph18.text.xl2.make().box.px32.make(),
          ])
              .box
              .margin(EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.125,
                  vertical: context.screenWidth * 0.03))
              .make()
              .scrollVertical()),
    );
  }
}
