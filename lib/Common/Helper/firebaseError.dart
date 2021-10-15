import 'package:flutter/material.dart';

showError(BuildContext context, String errormessage) {
  String msg =
      errormessage.replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
  print('see msg $msg');
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ok',
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        );
      });
}
