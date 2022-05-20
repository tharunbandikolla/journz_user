import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class NewTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  String? Function(String?)? validator;
  double? newWidth, newHeight;
  Widget? prefix;
  Widget? suffix;
  VoidCallback? onTap;
  Widget? prefixWidget;
  bool readOnly;
  TextInputType keyBoardType;

  int? maxLen;
  NewTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.keyBoardType,
      this.onTap,
      this.maxLen,
      this.prefixWidget,
      this.newWidth,
      this.suffix,
      required this.readOnly,
      this.prefix,
      this.newHeight,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: newWidth,
      height: newHeight,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        style: TextStyle(color: Colors.white),
        maxLength: maxLen,
        decoration: InputDecoration(
            prefix: prefixWidget,
            prefixIcon: prefix,
            suffix: suffix,
            filled: true,
            isDense: true,
            fillColor: Colors.black.withOpacity(0.35),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.screenWidth * 0.5)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.05,
                vertical: context.screenWidth * 0.04),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}
