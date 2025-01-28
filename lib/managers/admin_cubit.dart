import 'dart:developer';

import 'package:mycompass_admin_website/models/users_status_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/local_storage/cach_keys.dart';
import 'package:mycompass_admin_website/core/local_storage/cache_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/auth/user_data_model.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/family_model.dart';
import 'package:mycompass_admin_website/models/ids_model.dart';
import 'package:mycompass_admin_website/models/main/get_all_admins_data_model.dart';
import 'package:mycompass_admin_website/models/profile_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../controllers/notification_manager.dart';
import '../screens/admin/main/user_status/non_reponsed_model.dart';
export 'package:dio/dio.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit of(context) => BlocProvider.of<AdminCubit>(context);

  DioHelper dioHelper = DioHelper();

  late IO.Socket socket; // Declare the socket variable
  final List<Map<String, dynamic>> notifications = [];

  /// Initialize Socket and Notification Services
  void initializeSocketAndNotifications() {
    log("Initializing socket and notification services...");
    initializeNotifications();
    initializeSocket();
  }

  /// Initialize Notifications
  void initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // Default icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for socket events',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );

    // Request permissions to send notifications
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Initialize Socket Connection
  void initializeSocket() {
    log("Initializing socket...");
    const String baseUrl = 'https://riedbergapp.up.railway.app';

    // Initialize the socket
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    log("Connecting to $baseUrl...");

    // Connect to the server
    socket.connect();

    // Listen for the connect event
    socket.onConnect((_) {
      // log("Connected to $baseUrl and listening for events... from ${socket.id}");
      //
      // // Emit "join" event with recipientId
      // String? recipientId = CacheHelper.getString(key: CacheKeys.userId);
      // if (recipientId != null) {
      //   socket.emit("join", recipientId);
      //   log("Joined channel with recipientId: $recipientId");
      // } else {
      //   log("Recipient ID is null. Cannot join channel.");
      // }

      socket.emit("join", "adminRoom");
    });

    // Listen for "notification" events
    // socket.on("notification", (data) {
    //   log("Received notification: $data");
    //
    //   // Add the notification to the list
    //   // notifications.add({
    //   //   "title": data["title"],
    //   //   "description": data["description"],
    //   //   "createdAt": data["createdAt"],
    //   // });
    //
    //   // Emit state for UI update
    //   emit(NotificationReceivedState(notifications: notifications));
    //
    //   // Show the notification locally
    //   NotificationManager().showNotification(
    //     title: data["title"],
    //     body: data["description"],
    //     // targetScreen: RoutesName.showAllEmployees,
    //   );
    // });
    socket.on("statusUpdate", (data) {
      log("Received notification UsersStatus: $data");
      getUsersStatus();
      // emit(UsersStatusReceivedState(usersStatus: data));
    });

    socket.onDisconnect((_) {
      log("Socket disconnected.");
    });

    socket.onError((error) {
      log("Socket error: $error");
    });
  }

  @override
  Future<void> close() {
    socket.dispose(); // Dispose of the socket when the cubit is closed
    return super.close();
  }

  void createFastNotification({
    String? title,
    String? description,
  }) async {
    if (title == null || description == null) {
      emit(CreateFastNotificationLoading());
    } else {
      emit(CreateCustomNotificationLoading());
    }
    try {
      final response = await dioHelper.postData(
          endPoint: ApiConstants.createFastNotificationUrl,
          body: title != null && description != null
              ? {"notifyTitle": title, "notifyDescription": description}
              : null);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Emit a socket event to notify other clients
        String? recipientId = CacheHelper.getString(key: CacheKeys.userId);
        // if (recipientId != null) {
        //   socket.emit("notification_created", {
        //     "title": response.data["title"],
        //     "description": response.data["description"],
        //     "createdAt": DateTime.now().toString(),
        //     "recipientId": recipientId,
        //   });
        //   log("Emitting notification to recipientId: $recipientId");
        //
        // } else {
        //   log("Recipient ID is null. Cannot emit notification.");
        // }
        if (title == null || description == null) {
          emit(CreateFastNotificationSuccess());
        } else {
          emit(CreateCustomNotificationSuccess());
        }
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(CreateFastNotificationFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(CreateFastNotificationFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(CreateFastNotificationFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  //
  // void createFastNotification() async {
  //   emit(CreateFastNotificationLoading());
  //   try {
  //     final response = await dioHelper.postData(
  //         endPoint: ApiConstants.createFastNotificationUrl);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       emit(CreateFastNotificationSuccess());
  //     } else if (response.statusCode == 422 || response.statusCode == 404) {
  //       final errorMessage =
  //           response.data['message']?.toString() ?? 'Unknown error';
  //       logError(errorMessage);
  //       emit(CreateFastNotificationFailure(
  //           errorModel: ErrorModel(message: errorMessage)));
  //     } else {
  //       final errorMessage =
  //           response.data['message']?.toString() ?? 'Error in Creating Family';
  //       logError(errorMessage);
  //       emit(CreateFastNotificationFailure(
  //           errorModel: ErrorModel(message: errorMessage)));
  //     }
  //   } catch (e) {
  //     logError(e.toString());
  //     emit(CreateFastNotificationFailure(
  //         errorModel: ErrorModel(message: e.toString())));
  //   }
  // }

  void startBackgroundService() {
    // Start the background service
    /// TODO: implement startBackgroundService
    print('Starting background service...');

    // FlutterBackgroundService().configure(
    //   androidConfiguration: AndroidConfiguration(
    //     onStart: onServiceStarted,
    //     isInForegroundMode: true,
    //     notificationTitle: "App is Running",
    //     notificationContent: "Tap to open the app",
    //     notificationIcon: 'resource_icon',
    //   ),
    //   iosConfiguration: IosConfiguration(
    //     onForeground: onServiceStarted,
    //     onBackground: onServiceStarted,
    //   ),
    // );
    //
    // FlutterBackgroundService().start();
  }

  void onServiceStarted() {
    print('Background Service Started!');

    /// Your socket initialization logic here
    final String baseUrl = 'https://riedbergapp.up.railway.app';
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("Connected to socket...");
      String? recipientId = CacheHelper.getString(key: CacheKeys.userId);
      if (recipientId != null) {
        socket.emit("join", recipientId);
        print("Joined channel with recipientId: $recipientId");
      } else {
        print("Recipient ID is null. Cannot join channel.");
      }
    });

    socket.on("notification", (data) {
      print("Received notification: $data");
      showLocalNotification(
        title: data["title"],
        body: data["description"],
      );
    });
  }

  void showLocalNotification({required String title, required String body}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  UserDataModel userDataModel = UserDataModel();

  /// Login
  void login({
    required String email,
    required String password,
  }) async {
    emit(AdminLoginLoading());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.loginUrl,
        body: {
          'email': email,
          'password': password,
        },
      );
      print(" login response ${response.data}");
      if (response.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(response.data);

        await CacheHelper.putString(
          key: CacheKeys.token,
          value: userDataModel.authorization!.token ?? '',
        );
        await CacheHelper.putString(
          key: CacheKeys.email,
          value: userDataModel.result!.email ?? '',
        );
        await CacheHelper.putString(
          key: CacheKeys.userId,
          value: userDataModel.result!.sId ?? '',
        );
        logSuccess(
            'Login successful, email is ${CacheHelper.getString(key: CacheKeys.email)}');
        emit(AdminLoginSuccess(
          message: 'Reset code sent to email. Please verify the code.',
        ));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AdminLoginFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in login';
        logError(errorMessage);
        emit(AdminLoginFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      print(" login response in Catch${e.toString()}");

      logError(e.toString());
      emit(AdminLoginFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  ProfileModel? profileModel;

  void getProfile() async {
    emit(GetProfileLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getProfileUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        profileModel = ProfileModel.fromJson(response.data);
        print("profile data ${response.data}");
        print(profileModel?.result?.email);
        emit(GetProfileSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetProfileFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetProfileFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetProfileFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  IdsModel? idsModel;

  void getAllEmployeesAndFamiliesIsd() async {
    emit(GetAllEmployeesAndFamiliesIsdLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllIsdUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        idsModel = IdsModel.fromJson(response.data);
        emit(GetAllEmployeesAndFamiliesIsdSuccess());
        print("get all isd ${response.data}");
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllEmployeesAndFamiliesIsdFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllEmployeesAndFamiliesIsdFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(GetAllEmployeesAndFamiliesIsdFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  UsersStatusModel? usersStatusModel;

  void getUsersStatus() async {
    emit(GetUsersStatesLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getUserStatusUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        usersStatusModel = UsersStatusModel.fromJson(response.data);
        emit(GetUsersStatesSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetUsersStatesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetUsersStatesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(
          GetUsersStatesFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }



  NonResponsedModel? nonResponsedModel;

  void getNotResponsed() async {
    emit(NotResponsedLoading());
    try {

      final response = await dioHelper.getData(
        endPoint: ApiConstants.getNonResponders,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(NotResponsedSuccess());
        nonResponsedModel = NonResponsedModel.fromJson(response.data);
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['Error']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(
            NotResponsedFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(
            NotResponsedFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(NotResponsedFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }







}
