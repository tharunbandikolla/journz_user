// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HyperLink extends StatelessWidget {
//   const HyperLink({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Linkify(
//           text:
//               'https://www.google.com  navne@gnail.com Lorem Ipsum is simply dummy +918524823785 text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. www.google.com  https://console.firebase.google.com/u/5/project/journzsocialnetwork/authentication/users',
//           onOpen: onOpen,
//         ),
//       ),
//     );
//   }

//   Future<void> onOpen(LinkableElement link) async {
//     if (await canLaunch(link.url)) {
//       print('open link ${link.url}');
//       await launch(link.url);
//     } else {
//       throw "Cant open link ${link.url}";
//     }
//   }
// }

// Text buildTextWithLinks(String textToLink) =>
//     Text.rich(TextSpan(children: linkify(textToLink)));

// Future<void> openUrl(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// const String urlPattern = r'https?:/\/\\S+';
// const String emailPattern = r'\S+@\S+';
// const String phonePattern = r'[\d-]{9,}';
// final RegExp linkRegExp = RegExp(
//     '($urlPattern)|($emailPattern)|($phonePattern)',
//     caseSensitive: false);

// WidgetSpan buildLinkComponent(String text, String linkToOpen) => WidgetSpan(
//         child: InkWell(
//       child: Column(
//         children: [
//           //linkify(text),

//           /*   Text(
//             text,
//             style: TextStyle(
//               color: Colors.blueAccent,
//               decoration: TextDecoration.underline,
//             ),
//           ),*/
//         ],
//       ),
//       onTap: () => openUrl(linkToOpen),
//     ));

// List<InlineSpan> linkify(String text) {
//   final List<InlineSpan> list = <InlineSpan>[];
//   final RegExpMatch? match = linkRegExp.firstMatch(text);
//   if (match == null) {
//     list.add(TextSpan(text: text));
//     return list;
//   }

//   if (match.start > 0) {
//     list.add(TextSpan(text: text.substring(0, match.start)));
//   }

//   final String? linkText = match.group(0);
//   if (linkText!.contains(RegExp(urlPattern, caseSensitive: false))) {
//     list.add(buildLinkComponent(linkText, linkText));
//   } else if (linkText.contains(RegExp(emailPattern, caseSensitive: false))) {
//     list.add(buildLinkComponent(linkText, 'mailto:$linkText'));
//   } else if (linkText.contains(RegExp(phonePattern, caseSensitive: false))) {
//     list.add(buildLinkComponent(linkText, 'tel:$linkText'));
//   } else {
//     throw 'Unexpected match: $linkText';
//   }

//   list.addAll(linkify(text.substring(match.start + linkText.length)));

//   return list;
// }
