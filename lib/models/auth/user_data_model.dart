class UserDataModel {
  String? message;
  Authorization? authorization;
  UserData? result;

  UserDataModel({this.message, this.authorization, this.result});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    authorization = json['authorization'] != null
        ? new Authorization.fromJson(json['authorization'])
        : null;
    result =
    json['result'] != null ? new UserData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.authorization != null) {
      data['authorization'] = this.authorization!.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Authorization {
  String? token;

  Authorization({this.token});

  Authorization.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class UserData {
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? role;

  UserData({this.sId, this.userName, this.email, this.password, this.role});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    return data;
  }
}
