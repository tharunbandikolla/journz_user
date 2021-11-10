import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NewCircularElevattedButton extends StatelessWidget {
  String name;
  VoidCallback func;
  double padHorizontal, padVertical, fontSize;
  NewCircularElevattedButton(
      {Key? key,
      required this.name,
      required this.func,
      required this.fontSize,
      required this.padHorizontal,
      required this.padVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: func,
        child: Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        style: ButtonStyle(
            /* fixedSize: MaterialStateProperty.all(
                            Size.fromWidth(context.screenWidth * 0.65)),*/
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                horizontal: padHorizontal, //context.screenWidth * 0.1,
                vertical: padVertical)), //context.screenWidth * 0.025)),
            foregroundColor: getColor(Colors.white, Colors.black),
            backgroundColor: getColor(Colors.transparent, Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)),
            )));
  }
}

MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  final getColor = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorPressed;
    } else {
      return color;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}
