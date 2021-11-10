// import '/Common/Helper/FavouriteSelectionDialogCubit/favouriteselectiondialogbox_cubit.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:velocity_x/velocity_x.dart';

// class FavCategoryButton extends StatefulWidget {
//   String? category, favCategory, photoUrl;
//   Function(List<dynamic>) callback;
//   List? favCategoryList;
//   FavCategoryButton(
//       {Key? key,
//       this.category,
//       required this.callback,
//       this.favCategory,
//       this.photoUrl,
//       this.favCategoryList})
//       : super(key: key);

//   @override
//   _FavCategoryButtonState createState() => _FavCategoryButtonState();
// }

// class _FavCategoryButtonState extends State<FavCategoryButton> {
//   List<dynamic> newFavouriteList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final favCategoryButton =
//         BlocProvider.of<FavouriteselectiondialogboxCubit>(context);
//     favCategoryButton.initialValue(
//       widget.favCategoryList!,
//       widget.category,
//     );
//     return BlocBuilder<FavouriteselectiondialogboxCubit,
//         FavouriteselectiondialogboxState>(
//       builder: (context, fcState) {
//         newFavouriteList = fcState.favouriteList!;
//         print('nnn new $newFavouriteList');
//         return InkWell(
//           onTap: () {
//             if (newFavouriteList.contains(widget.category)) {
//               newFavouriteList.remove(widget.category);
//               widget.callback(newFavouriteList);
//               favCategoryButton.initialValue(newFavouriteList, widget.category);
//             } else {
//               newFavouriteList.add(widget.category);
//               widget.callback(newFavouriteList);
//               favCategoryButton.initialValue(newFavouriteList, widget.category);
//             }
//           },
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   VxBox()
//                       .roundedFull
//                       .square(context.screenWidth * 0.13)
//                       .red400
//                       .bgImage(DecorationImage(
//                           fit: BoxFit.cover,
//                           image: CachedNetworkImageProvider(widget.photoUrl!)))
//                       .makeCentered(),
//                   5.heightBox,
//                   Text(widget.category!)
//                       .text
//                       .overflow(TextOverflow.ellipsis)
//                       .tight
//                       .sm
//                       .makeCentered(),
//                   /* .box
//                       .square(150)
//                       .coolGray400
//                       .p12
//                       .makeCentered(), */
//                 ],
//               ).box.square(context.screenWidth * 0.25).makeCentered(),
//               fcState.val!
//                   ? Align(
//                       alignment: Alignment.topRight,
//                       child: Icon(
//                         FontAwesomeIcons.checkCircle,
//                         size: 15,
//                       ))
//                   : Container(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
