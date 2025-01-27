// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class NotificationManager {
//   static final NotificationManager _instance = NotificationManager._internal();
//
//   factory NotificationManager() => _instance;
//
//   NotificationManager._internal();
//
//   // Add this to handle notification clicks
//   // void handleNotificationClicks(GlobalKey<NavigatorState> navigatorKey) {
//   //   logWarning('handleNotificationClicks');
//   //   AwesomeNotifications().().then((onValue){
//   //     logWarning('onValue: $onValue');
//   //     String? targetScreen = onValue?.payload?['target_screen'];
//   //
//   //     logWarning('targetScreen: $targetScreen');
//   //     if (targetScreen == RoutesName.showAllAnnouncements) {
//   //       // navigatorKey.currentState?.pushNamed(RoutesName.showAllAnnouncements);
//   //       Navigator.pushNamed(navigatorKey.currentContext!, RoutesName.showAllAnnouncements);
//   //       logWarning('pushNamed: ${RoutesName.showAllAnnouncements}');
//   //     }
//   //   });
//   //
//   // }
//
//   ////////////////////////////////////////////////////////////
//
//   Future<void> initializeNotifications() async {
//     await AwesomeNotifications().initialize(
//       null, // Default icon
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Notifications',
//           channelDescription: 'Notification channel for general app notifications',
//           defaultColor: const Color(0xFF9D50DD),
//           importance: NotificationImportance.High,
//           channelShowBadge: true,
//         ),
//       ],
//     );
//
//     // Request permission to send notifications
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   /// Show a local notification
//   // Future<void> showNotification({
//   //   required String title,
//   //   required String body,
//   // }) async {
//   //   await AwesomeNotifications().createNotification(
//   //     content: NotificationContent(
//   //       id: Random().nextInt(100000), // Unique ID for the notification
//   //       channelKey: 'basic_channel',
//   //       title: title,
//   //       body: body,
//   //       notificationLayout: NotificationLayout.Default,
//   //     ),
//   //   );
//   // }
//   /// Show a local notification
//   Future<void> showNotification({
//     required String title,
//     required String body,
//     String? targetScreen, // Add an optional target screen parameter
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: Random().nextInt(100000), // Unique ID for the notification
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//         notificationLayout: NotificationLayout.Default,
//         payload: {'target_screen': targetScreen ?? ''}, // Include the target screen in the payload
//       ),
//     );
//   }
// }
