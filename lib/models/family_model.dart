// FamilyModel
// OneFamily

class FamilyModel {
  String? status;
  String? message;
  List<OneFamily>? result;

  FamilyModel({this.status, this.message, this.result});

  FamilyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <OneFamily>[];
      json['result'].forEach((v) {
        result!.add(new OneFamily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OneFamily {
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? phone;
  int? noOfAppartment;
  String? maintenanceDay;
  String? memberType;
  String? role;

  // List<Null>? userProblems;
  bool? isDeleted;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OneFamily(
      {this.sId,
      this.userName,
      this.email,
      this.password,
      this.phone,
      this.noOfAppartment,
      this.maintenanceDay,
      this.memberType,
      this.role,
      // this.userProblems,
      this.isDeleted,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OneFamily.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    noOfAppartment = json['noOfAppartment'];
    maintenanceDay = json['maintenanceDay'];
    memberType = json['memberType'];
    role = json['role'];
    // if (json['userProblems'] != null) {
    //   userProblems = <Null>[];
    //   json['userProblems'].forEach((v) {
    //     userProblems!.add(new Null.fromJson(v));
    //   });
    // }
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['noOfAppartment'] = this.noOfAppartment;
    data['maintenanceDay'] = this.maintenanceDay;
    data['memberType'] = this.memberType;
    data['role'] = this.role;
    // if (this.userProblems != null) {
    //   data['userProblems'] = this.userProblems!.map((v) => v.toJson()).toList();
    // }
    data['isDeleted'] = this.isDeleted;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
