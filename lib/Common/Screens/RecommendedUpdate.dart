// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:velocity_x/velocity_x.dart';

// class RecommendedUpdateDialog extends StatefulWidget {
//   String? mainMsg;
//   RecommendedUpdateDialog({Key? key, this.mainMsg}) : super(key: key);

//   @override
//   _RecommendedUpdateDialogState createState() =>
//       _RecommendedUpdateDialogState();
// }

// class _RecommendedUpdateDialogState extends State<RecommendedUpdateDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       color: Colors.transparent,
//       width: context.screenWidth,
//       height: context.screenHeight,
//       child: Stack(
//         children: [
//           Container(
//             color: Colors.grey.withOpacity(0.8),
//             width: context.screenWidth * 0.75,
//             height: context.screenHeight * 0.45,
//           ).positioned(
//               left: context.screenWidth * 0.125,
//               top: context.screenHeight * 0.325),
//           VxArc(
//                   height: 20,
//                   edge: VxEdge.TOP,
//                   arcType: VxArcType.CONVEY,
//                   child: Container(
//                       color: Colors.white,
//                       width: context.screenWidth * 0.75,
//                       height: context.screenHeight * 0.3))
//               .positioned(
//                   left: context.screenWidth * 0.125,
//                   top: context.screenHeight * 0.5),
//           RotationTransition(
//             turns: AlwaysStoppedAnimation(1200 / 1400),
//             child: Icon(
//               FontAwesomeIcons.broom,
//               color: Colors.grey[300],
//               size: 55,
//             ),
//           ).positioned(
//               left: context.screenWidth * 0.4025,
//               top: context.screenHeight * 0.4),
//           RotationTransition(
//             turns: AlwaysStoppedAnimation(2.87466666667),
//             child: Icon(
//               FontAwesomeIcons.rocket,
//               color: Colors.grey[300],
//               size: 100,
//             ),
//           ).positioned(
//               left: context.screenWidth * 0.35,
//               top: context.screenHeight * 0.31),
//           "HI! THERE..".text.bold.black.xl3.make().positioned(
//               left: context.screenWidth * 0.33,
//               top: context.screenHeight * 0.55),
//           widget.mainMsg!.text.center.black.xl2
//               .make()
//               .box
//               .width(context.screenWidth * 0.65)
//               .make()
//               .positioned(
//                   left: context.screenWidth * 0.175,
//                   top: context.screenHeight * 0.6),
//           HStack(
//             [
//               "Ignore"
//                   .text
//                   .xl
//                   .bold
//                   .makeCentered()
//                   .box
//                   .width(context.screenWidth * 0.37)
//                   .black
//                   .p12
//                   .make(),
//               "Update"
//                   .text
//                   .xl
//                   .bold
//                   .makeCentered()
//                   .box
//                   .width(context.screenWidth * 0.37)
//                   .black
//                   .p12
//                   .make()
//             ],
//             alignment: MainAxisAlignment.spaceEvenly,
//           ).box.width(context.screenWidth * 0.75).make().positioned(
//               left: context.screenWidth * 0.125,
//               top: context.screenHeight * 0.74),
//         ],
//       ),
//     ));
//   }
// }
