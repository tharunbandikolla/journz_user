import 'package:flutter/material.dart';

ShowErrorDialogNormal(BuildContext context, String error) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(error),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        );
      });
}

ShowErrorDialog(BuildContext context, Object error) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(error.toString().split(']').last),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        );
      });
}
