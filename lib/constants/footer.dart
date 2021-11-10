@JS()
library javascript_bundler;

import 'package:flutter/material.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:js/js.dart';

@JS('confirm')
external void showConfirm(String text);

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              context.vxNav.push(
                Uri(
                    // path: MyRoutes.detailRoute,
                    // queryParameters: {"type": "", "id": ds.id}
                    path: MyRoutes.detailnewRoute,
                    queryParameters: {"type": "/PrivacyPolicy"}),
              );
            },
            child: "Privacy Policy".text.white.make(),
          ),
          SizedBox(width: context.screenWidth * 0.005),
          "Copyright @ 2020 Journz".text.white.make()
        ],
      ),
    );
  }
}
