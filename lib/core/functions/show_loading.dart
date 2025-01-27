
import 'package:flutter/material.dart';


showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const SizedBox(
      height: 20,
      width: 20,
      child: Card(
        child:  Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}


