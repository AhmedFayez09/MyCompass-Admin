class ProfileModel {
  String? status;
  String? message;
  ProfileModelData? result;

  ProfileModel({this.status, this.message, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ?   ProfileModelData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class ProfileModelData {
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProfileModelData(
      {this.sId,
        this.userName,
        this.email,
        this.password,
        this.phone,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
