// import 'package:bloc/bloc.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:share/share.dart';
// part 'detailviewdynamiclink_state.dart';

// class DetailviewdynamiclinkCubit extends Cubit<DetailviewdynamiclinkState> {
//   DetailviewdynamiclinkCubit() : super(DetailviewdynamiclinkState());

//   Future<void> createDynamicLink(bool short, String idfordoc, String title,
//       String screen, String desc) async {
//     print('nnn build dynamic $idfordoc');
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         navigationInfoParameters:
//             NavigationInfoParameters(forcedRedirectEnabled: true),
//         uriPrefix: 'https://journz.in',
//         link: Uri.parse('https://journz.in/?type=$screen&id=$idfordoc'),
//         androidParameters: AndroidParameters(
//             fallbackUrl: Uri.parse(
//                 'https://play.google.com/store/apps/details?id=in.journz.journz'),
//             packageName: "in.journz.journz",
//             minimumVersion: 0),
//         dynamicLinkParametersOptions: DynamicLinkParametersOptions(
//             shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
//         socialMetaTagParameters:
//             SocialMetaTagParameters(title: title, description: desc));
//     Uri uri;
//     if (short) {
//       final ShortDynamicLink shortDynamicLink =
//           await parameters.buildShortLink();
//       Share.share('$title ${shortDynamicLink.shortUrl}');
//     } else {
//       uri = await parameters.buildUrl();
//       Share.share('$title $uri');
//     }
//   }
// }
