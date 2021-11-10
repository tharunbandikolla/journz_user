// import '/Common/Helper/LoadArticleBasedOnSubTypeCubit/loadarticlesbasedonsubtype_cubit.dart';
// import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';
// import '/Common/Screens/NewHomeScreenArticleSection.dart';
// import '/HomeScreen/Bloc/ArticleCubit/article_cubit.dart';

// import '/HomeScreen/Bloc/HomeScreenLike/homescreenlike_cubit.dart';
// import '/HomeScreen/Bloc/PlannedHomeScreenBloc/plannedhomescreen_bloc.dart';
// import '/HomeScreen/Bloc/SelectedCategoryCubit/selectedcategory_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NewPlannedHomeScreen extends StatefulWidget {
//   const NewPlannedHomeScreen({Key? key}) : super(key: key);

//   @override
//   _NewPlannedHomeScreenState createState() => _NewPlannedHomeScreenState();
// }

// class _NewPlannedHomeScreenState extends State<NewPlannedHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final homeScreenBloc = BlocProvider.of<PlannedhomescreenBloc>(context);
//     homeScreenBloc.add(GetArticleSubtypeForHomeScreen());
//     return Scaffold(
//       body: Container(
//         child: BlocBuilder<PlannedhomescreenBloc, PlannedhomescreenState>(
//           builder: (context, state) {
//             if (state is ShowArticleSubtypeState) {
//               if (state.SubTypeList != null) {
//                 print('nnn subtypeList ${state.SubTypeList}');
//                 homeScreenBloc.add(GetArticleForHomeScreen(
//                     articleSubtypeList: state.SubTypeList));
//               }
//               return Center(child: CircularProgressIndicator());
//             } else if (state is ShowArticleState) {
//               if (state.articleSubtypeList != null &&
//                   state.docLength != null &&
//                   state.lastDoc != null &&
//                   state.splitedData != null) {
//                 homeScreenBloc.add(GetFavouriteArticleForHomeScreen(
//                     article: state.splitedData,
//                     docLength: state.docLength,
//                     lastdoc: state.lastDoc,
//                     subtype: state.articleSubtypeList));
//               }
//               return Center(child: CircularProgressIndicator());
//             } else if (state is ShowFavouriteArticleState) {
//               print(
//                   'favourdata ${state.article}  ${state.docLength} ${state.favouriteArticle} ${state.lastdoc} ${state.subtype}');
//               return FutureBuilder(
//                   future: Future.delayed(Duration(seconds: 0))
//                       .then((value) => Future.value(true)),
//                   builder: (context, snapshot) {
//                     return snapshot.hasData
//                         ? Center(
//                             child: MultiBlocProvider(
//                                 providers: [
//                                   BlocProvider(
//                                       create: (context) =>
//                                           LoadarticlesbasedonsubtypeCubit()),
//                                   BlocProvider(
//                                       create: (context) => ArticleCubit()),
//                                   BlocProvider(
//                                       create: (context) =>
//                                           HomescreenlikeCubit()),
//                                   BlocProvider(
//                                       create: (context) =>
//                                           LoaddatapartbypartCubit()),
//                                   BlocProvider(
//                                       create: (context) =>
//                                           SelectedcategoryCubit(
//                                               state.favouriteArticle!)),
//                                 ],
//                                 child: HomeScreenArticleSectionTry(
//                                   favCatgoryList: state.favouriteArticle,
//                                   articlesList: state.article,
//                                   subtypeList: state.subtype,
//                                   userCountry: state.country,
//                                 )),
//                           )
//                         : Center(
//                             child: CircularProgressIndicator(),
//                           );
//                   });
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
