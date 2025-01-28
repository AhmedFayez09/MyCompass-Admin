import 'package:mycompass_admin_website/screens/admin/main/users_status_screen.dart';

class UsersStatusModel {
  String? status;
  String? message;
  int? count;
  List<UsersStatusModelData?>? result;
  List<UsersStatusModelData?>? oneList;
  List<UsersStatusModelData?>? twoList;
  List<UsersStatusModelData?>? threeList;

  UsersStatusModel({this.status, this.message, this.count, this.result,this.oneList});

  UsersStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['result'] != null) {
      result = <UsersStatusModelData>[];
      json['result'].forEach((v) {
        result!.add(  UsersStatusModelData.fromJson(v));
      });
    }
    oneList = result?.map((e) => e?.status == usersStatus[0] ? e : null).where((e) => e != null).toList();
    twoList = result?.map((e) => e?.status == usersStatus[1] ? e : null).where((e) => e != null).toList();
    threeList = result?.map((e) => e?.status == usersStatus[2] ? e : null).where((e) => e != null).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['count'] = count;
    if (result != null) {
      data['result'] = result!.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class UsersStatusModelData {
  String? sId;
  String? notificationId;
  String? userId;
  String? userType;
  String? userName;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UsersStatusModelData(
      {this.sId,
        this.notificationId,
        this.userId,
        this.userType,
        this.userName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UsersStatusModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    notificationId = json['notificationId'];
    userId = json['userId'];
    userType = json['userType'];
    userName = json['userName'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['notificationId'] = notificationId;
    data['userId'] = userId;
    data['userType'] = userType;
    data['userName'] = userName;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
