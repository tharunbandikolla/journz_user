@JS()
library javascript_bundler;
import 'package:flutter/material.dart';
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
        children: ["Copyright @ 2020 Journz".text.white.make()],
      ),
    );
  }
}
