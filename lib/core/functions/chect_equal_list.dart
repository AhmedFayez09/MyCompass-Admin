import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

bool areListsIdentical(List<String> list1, List<String> list2) {
  if (list1.length != list2.length) return false;

  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) return false;
  }
  return true;
}


String extractDate(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime); // Parse the ISO string
  return DateFormat('yyyy-MM-dd').format(parsedDate); // Format to '2025-01-20'
}




void zoomImage(BuildContext context, String? image) {
  showDialog(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            Card(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: PhotoView(
                    imageProvider: NetworkImage(image ?? ''),
                  )),
            ),
            const Positioned(
              top: 10,
              left: 10,
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ));
}
