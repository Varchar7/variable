import 'package:flutter/material.dart';
import 'package:variable/widget/style.dart';

showMyDailog(
  BuildContext context, {
  required String title,
  required VoidCallback onSubmit,
  required VoidCallback onCancel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: style(),
        ),
        actionsPadding: const EdgeInsets.only(right: 20),
        shape: const StadiumBorder(),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: Colors.greenAccent,
            ),
            onPressed: onSubmit,
            child: Text(
              "Sure",
              style: style(),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: Colors.greenAccent,
            ),
            onPressed: onCancel,
            child: Text(
              "Cancel",
              style: style(),
            ),
          ),
        ],
      );
    },
  );
}
