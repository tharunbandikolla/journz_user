// import '/Common/Constant/Constants.dart';
// import '/Common/Helper/BottomNavBar/bottomnavbar_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class BottomNavBarWidget extends StatefulWidget {
//   const BottomNavBarWidget({Key? key}) : super(key: key);

//   @override
//   _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
// }

// class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final bottomNavBarCubit = BlocProvider.of<BottomnavbarCubit>(context);
//     return BlocBuilder<BottomnavbarCubit, BottomnavbarState>(
//       builder: (context, state) {
//         return Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(45),
//                   topLeft: Radius.circular(45),
//                   bottomLeft: Radius.circular(45),
//                   topRight: Radius.circular(45)),
//               side: BorderSide(width: 0.5, color: Colors.grey)),
//           elevation: 12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FittedBox(
//                 child: Column(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     /*SizedBox(
//                       height: 10,
//                     ),
//                      state.currentIndex == 0
//                         ? Container(
//                             width: getWidth(context) * 0.175,
//                             height: 2,
//                             color: Colors.white)
//                         : Container(),*/
//                     IconButton(
//                       icon: Icon(
//                         FontAwesomeIcons.artstation,
//                         size: state.currentIndex == 0
//                             ? getWidth(context) * 0.08
//                             : getWidth(context) * 0.065,
//                       ),
//                       onPressed: () {
//                         bottomNavBarCubit.setCurrentIndex(0);
//                       },
//                     ),
//                     state.currentIndex == 0 ? Text('Articles') : Container(),
//                     SizedBox(
//                       height: getWidth(context) * 0.02,
//                     )
//                   ],
//                 ),
//               ),
//               FittedBox(
//                 child: Column(
//                   children: [
//                     /* state.currentIndex == 1
//                         ? Container(
//                             width: getWidth(context) * 0.175,
//                             height: 2,
//                             color: Colors.white)
//                         : Container(),*/
//                     IconButton(
//                       icon: Icon(FontAwesomeIcons.newspaper,
//                           size: state.currentIndex == 1
//                               ? getWidth(context) * 0.08
//                               : getWidth(context) * 0.065),
//                       onPressed: () {
//                         bottomNavBarCubit.setCurrentIndex(1);
//                       },
//                     ),
//                     state.currentIndex == 1 ? Text('News') : Container(),
//                     SizedBox(
//                       height: getWidth(context) * 0.02,
//                     )
//                   ],
//                 ),
//               ),
//               FittedBox(
//                 child: Column(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     /*state.currentIndex == 2
//                         ? Container(
//                             width: getWidth(context) * 0.175,
//                             height: 2,
//                             color: Colors.white)
//                         : Container(),*/
//                     IconButton(
//                       icon: Icon(FontAwesomeIcons.playCircle,
//                           size: state.currentIndex == 2
//                               ? getWidth(context) * 0.08
//                               : getWidth(context) * 0.065),
//                       onPressed: () {
//                         bottomNavBarCubit.setCurrentIndex(2);
//                       },
//                     ),
//                     state.currentIndex == 2 ? Text('FunBits') : Container(),
//                     SizedBox(
//                       height: getWidth(context) * 0.02,
//                     )
//                   ],
//                 ),
//               ),
//               FittedBox(
//                 child: Column(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     /*state.currentIndex == 3
//                         ? Container(
//                             width: getWidth(context) * 0.175,
//                             height: 2,
//                             color: Colors.white)
//                         : Container(),*/
//                     IconButton(
//                       icon: Icon(FontAwesomeIcons.comment,
//                           size: state.currentIndex == 3
//                               ? getWidth(context) * 0.08
//                               : getWidth(context) * 0.065),
//                       onPressed: () {
//                         bottomNavBarCubit.setCurrentIndex(3);
//                       },
//                     ),
//                     state.currentIndex == 3 ? Text('Chat') : Container(),
//                     SizedBox(
//                       height: getWidth(context) * 0.02,
//                     )
//                   ],
//                 ),
//               ),
//               FittedBox(
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     /*state.currentIndex == 4
//                         ? Container(
//                             width: getWidth(context) * 0.175,
//                             height: 2,
//                             color: Colors.white)
//                         : Container(),*/
//                     IconButton(
//                       icon: Icon(FontAwesomeIcons.userCircle,
//                           size: state.currentIndex == 4
//                               ? getWidth(context) * 0.08
//                               : getWidth(context) * 0.065),
//                       onPressed: () {
//                         bottomNavBarCubit.setCurrentIndex(4);
//                       },
//                     ),
//                     state.currentIndex == 4 ? Text('Profile') : Container(),
//                     SizedBox(
//                       height: getWidth(context) * 0.02,
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
