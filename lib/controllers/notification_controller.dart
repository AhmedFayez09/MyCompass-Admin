import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/main.dart';

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // Default icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription:
          'Notification channel for general app notifications',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );

    // Request permission to send notifications
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }



  Future<void> showNotification({
    required String title,
    required String body,
    String? targetScreen, // Add an optional target screen parameter
  }) async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100000),
        // Unique ID for the notification
        channelKey: 'basic_channel',
        title: title,
        body: body,

        notificationLayout: NotificationLayout.Default,
        payload: {
          'target_screen': targetScreen ?? ''
        }, // Include the target screen in the payload
      ),
    );
  }



  static ReceivePort? receivePort;
  static Future<void> initializeIsolateReceivePort({required String routeName}) async {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
              (silentData) => onActionReceivedImplementationMethod(silentData, routeName: routeName));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  /// The method must match the ActionHandler type
  // @pragma('vm:entry-point')
  // static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  //   if (receivedAction.actionType == ActionType.SilentAction ||
  //       receivedAction.actionType == ActionType.SilentBackgroundAction) {
  //     // For background actions, you must hold the execution until the end
  //     print(
  //         'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
  //     await executeLongTaskInBackground();
  //   } else {
  //     // This process is only necessary when you need to redirect the user
  //     // to a new page or use a valid context, since parallel isolates do not
  //     // have valid context, so you need to redirect the execution to the main isolate
  //     if (receivePort == null) {
  //       print(
  //           'onActionReceivedMethod was called inside a parallel dart isolate.');
  //       SendPort? sendPort =
  //       IsolateNameServer.lookupPortByName('notification_action_port');
  //
  //       if (sendPort != null) {
  //         print('Redirecting the execution to main isolate process.');
  //         sendPort.send(receivedAction);
  //         return;
  //       }
  //     }
  //
  //     // Implement your app's navigation logic here
  //     // Example: Navigate to a specific route based on notification payload
  //     if (receivedAction.payload != null &&
  //         receivedAction.payload!.containsKey('route_name')) {
  //       String routeName = receivedAction.payload!['route_name']!;
  //       print('Navigating to route: $routeName');
  //       // Use your navigator or other logic to navigate
  //     }
  //
  //     return onActionReceivedImplementationMethod(receivedAction, routeName: receivedAction.payload!['route_name']!);
  //   }
  // }
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      print('Silent action received: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      String? routeName = receivedAction.payload?['target_screen'];
      if (routeName != null && routeName.isNotEmpty) {
        print('Navigating to route: $routeName');
        navigatorKey.currentState?.pushNamed(routeName, arguments: receivedAction);
      }
    }
  }

  /// Implement your navigation or handling logic here
  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction,
      {required String routeName}
      ) async {
    // Your app-specific logic for handling the notification action
    print('Handling notification action: ${receivedAction.id}');
  }

  // ///  *********************************************
  // ///     NOTIFICATION EVENTS LISTENER
  // ///  *********************************************
  // ///  Notifications events are only delivered after call this method
  // static Future<void> startListeningNotificationEvents() async {
  //   AwesomeNotifications()
  //       .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  // }
  //
  // ///  *********************************************
  // ///     NOTIFICATION EVENTS
  // ///  *********************************************
  // ///
  // @pragma('vm:entry-point')
  // static Future<void> onActionReceivedMethod(
  //     ReceivedAction receivedAction,
  // {required String routeName,}
  //     ) async {
  //   if (receivedAction.actionType == ActionType.SilentAction ||
  //       receivedAction.actionType == ActionType.SilentBackgroundAction) {
  //     // For background actions, you must hold the execution until the end
  //     print(
  //         'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
  //     await executeLongTaskInBackground();
  //   } else {
  //     // this process is only necessary when you need to redirect the user
  //     // to a new page or use a valid context, since parallel isolates do not
  //     // have valid context, so you need redirect the execution to main isolate
  //     if (receivePort == null) {
  //       print(
  //           'onActionReceivedMethod was called inside a parallel dart isolate.');
  //       SendPort? sendPort =
  //       IsolateNameServer.lookupPortByName('notification_action_port');
  //
  //       if (sendPort != null) {
  //         print('Redirecting the execution to main isolate process.');
  //         sendPort.send(receivedAction);
  //         return;
  //       }
  //     }
  //
  //     return onActionReceivedImplementationMethod(receivedAction, routeName: routeName);
  //   }
  // }
  //
  // static Future<void> onActionReceivedImplementationMethod(
  //     ReceivedAction receivedAction, {required String routeName}) async {
  //   // Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, FamilyDataScreen.routeName, (Route route) => false);
  //   navigatorKey.currentState?.pushNamedAndRemoveUntil(
  //       routeName,
  //           (route) =>
  //       (route.settings.name != routeName) || route.isFirst,
  //       arguments: receivedAction);
  // }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  // static Future<bool> displayNotificationRationale() async {
  //   bool userAuthorized = false;
  //   // BuildContext context = MyApp.navigatorKey.currentContext!;
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return AlertDialog(
  //           title: Text('Get Notified!',
  //               style: Theme.of(context).textTheme.titleLarge),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Image.asset(
  //                       'assets/images/animated-bell.gif',
  //                       height: MediaQuery.of(context).size.height * 0.3,
  //                       fit: BoxFit.fitWidth,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               const Text(
  //                   'Allow Awesome Notifications to send you beautiful notifications!'),
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(ctx).pop();
  //                 },
  //                 child: Text(
  //                   'Deny',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .titleLarge
  //                       ?.copyWith(color: Colors.red),
  //                 )),
  //             TextButton(
  //                 onPressed: () async {
  //                   userAuthorized = true;
  //                   Navigator.of(ctx).pop();
  //                 },
  //                 child: Text(
  //                   'Allow',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .titleLarge
  //                       ?.copyWith(color: Colors.deepPurple),
  //                 )),
  //           ],
  //         );
  //       });
  //   return userAuthorized &&
  //       await AwesomeNotifications().requestPermissionToSendNotifications();
  // }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    // final re = await http.get(url);
    // print(re.body);
    print("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  // static Future<void> createNewNotification() async {
  //   bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  //   if (!isAllowed) isAllowed = await displayNotificationRationale();
  //   if (!isAllowed) return;
  //
  //   await AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: -1, // -1 is replaced by a random number
  //           channelKey: 'alerts',
  //           title: 'Huston! The eagle has landed!',
  //           body:
  //           "A small step for a man, but a giant leap to Flutter's community!",
  //           bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
  //           largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
  //           //'asset://assets/images/balloons-in-sky.jpg',
  //           notificationLayout: NotificationLayout.BigPicture,
  //           payload: {'notificationId': '1234567890'}),
  //       actionButtons: [
  //         NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
  //         NotificationActionButton(
  //             key: 'REPLY',
  //             label: 'Reply Message',
  //             requireInputText: true,
  //             actionType: ActionType.SilentAction),
  //         NotificationActionButton(
  //             key: 'DISMISS',
  //             label: 'Dismiss',
  //             actionType: ActionType.DismissAction,
  //             isDangerousOption: true)
  //       ]);
  // }

  // static Future<void> scheduleNewNotification() async {
  //   bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  //   if (!isAllowed) isAllowed = await displayNotificationRationale();
  //   if (!isAllowed) return;
  //
  //   await myNotifyScheduleInHours(
  //       title: 'test',
  //       msg: 'test message',
  //       heroThumbUrl:
  //       'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
  //       hoursFromNow: 5,
  //       username: 'test user',
  //       repeatNotif: false);
  // }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}

Future<void> myNotifyScheduleInHours({
  required int hoursFromNow,
  required String heroThumbUrl,
  required String username,
  required String title,
  required String msg,
  bool repeatNotif = false,
}) async {
  var nowDate = DateTime.now().add(Duration(hours: hoursFromNow, seconds: 5));
  await AwesomeNotifications().createNotification(
    schedule: NotificationCalendar(
      //weekday: nowDate.day,
      hour: nowDate.hour,
      minute: 0,
      second: nowDate.second,
      repeats: repeatNotif,
      //allowWhileIdle: true,
    ),
    // schedule: NotificationCalendar.fromDate(
    //    date: DateTime.now().add(const Duration(seconds: 10))),
    content: NotificationContent(
      id: -1,
      channelKey: 'basic_channel',
      title: '${Emojis.food_bowl_with_spoon} $title',
      body: '$username, $msg',
      bigPicture: heroThumbUrl,
      notificationLayout: NotificationLayout.BigPicture,
      //actionType : ActionType.DismissAction,
      color: Colors.black,
      backgroundColor: Colors.black,
      // customSound: 'resource://raw/notif',
      payload: {'actPag': 'myAct', 'actType': 'food', 'username': username},
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'NOW',
        label: 'btnAct1',
      ),
      NotificationActionButton(
        key: 'LATER',
        label: 'btnAct2',
      ),
    ],
  );
}