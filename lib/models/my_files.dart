import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/constants.dart';

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

List demoMyFiles = [
  CloudStorageInfo(
    title: "جميع العائلات الحاليين",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_profile.svg",
    totalStorage: "200 عائلة",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "جميع المستخدمين المحظورين",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "20 عائلة",
    color: const Color(0xFFFFA113),
    percentage: 35,
  ),
];
