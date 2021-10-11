import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textFieldHeader(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.only(left: getWidth(context) * 0.042),
    child: Text(title,
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                fontSize: getWidth(context) * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.red))),
  );
}
