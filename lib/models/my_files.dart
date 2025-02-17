import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

// List demoMyFiles (BuildContext context)=> [
//   CloudStorageInfo(
//     title: "AllCurrentFamilies".tr(context),
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/menu_profile.svg",
//     totalStorage: "200 ${"family".tr(context)}",
//     color: primaryColor,
//     percentage: 35,
//   ),
//   CloudStorageInfo(
//     title: "",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/google_drive.svg",
//     totalStorage: "20 ${"family".tr(context)}",
//     color: const Color(0xFFFFA113),
//     percentage: 35,
//   ),
// ];
