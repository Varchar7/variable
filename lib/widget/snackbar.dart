import 'package:flutter/material.dart';

popSnackbar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: 'Ubuntu'),
      ),
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      margin: const EdgeInsets.all(8),
    ),
  );
}
