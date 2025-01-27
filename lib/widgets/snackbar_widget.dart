import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/constants.dart';

class SnackbarWidget {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: secondaryColor,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
