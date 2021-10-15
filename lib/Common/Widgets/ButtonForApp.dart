import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  GlobalKey ctx;
  AppButton({Key? key, required this.ctx, this.title, this.func})
      : super(key: key);

  final String? title;
  final void Function()? func;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  var ctx1;
  @override
  initState() {
    super.initState();
    ctx1 = widget.ctx.currentContext;
  }

  @override
  Widget build(BuildContext ctx1) {
    return InkWell(
      onTap: widget.func!,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius:
                  BorderRadius.all(Radius.circular(getWidth(ctx1) * 0.08))),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getWidth(ctx1) * 0.015,
                horizontal: getWidth(ctx1) * 0.07),
            child: Text(
              widget.title!,
              style: TextStyle(
                  color: Colors.white, fontSize: getWidth(ctx1) * 0.05),
            ),
          )),
    );
  }
}
