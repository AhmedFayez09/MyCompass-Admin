import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/constants.dart';

ButtonStyle buildStyleFrom() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultPadding / 2),
    ),
  );
}