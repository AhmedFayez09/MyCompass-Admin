class EmployeeModel {
  String? status;
  String? message;
  List<EmployeeModelData>? result;

  EmployeeModel({this.status, this.message, this.result});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <EmployeeModelData>[];
      json['result'].forEach((v) {
        result!.add(EmployeeModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class EmployeeModelData {
//   String? sId;
//   String? userName;
//   String? email;
//   String? password;
//   String? phone;
//   String? role;
//   List<String>? languages;
//   List<String>? days;
//   bool? isDeleted;
//   bool? isBlocked;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   List<Schedule>? schedule;
//
//   EmployeeModelData(
//       {this.sId,
//         this.userName,
//         this.email,
//         this.password,
//         this.phone,
//         this.role,
//         this.languages,
//         this.days,
//         this.isDeleted,
//         this.isBlocked,
//         this.createdAt,
//         this.updatedAt,
//         this.iV,
//         this.schedule});
//
//   EmployeeModelData.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userName = json['userName'];
//     email = json['email'];
//     password = json['password'];
//     phone = json['phone'];
//     role = json['role'];
//     languages = json['languages'].cast<String>();
//     days = json['days'].cast<String>();
//     isDeleted = json['isDeleted'];
//     isBlocked = json['isBlocked'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     if (json['schedule'] != null) {
//       schedule = <Schedule>[];
//       json['schedule'].forEach((v) {
//         schedule!.add(new Schedule.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['userName'] = this.userName;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phone'] = this.phone;
//     data['role'] = this.role;
//     data['languages'] = this.languages;
//     data['days'] = this.days;
//     data['isDeleted'] = this.isDeleted;
//     data['isBlocked'] = this.isBlocked;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     if (this.schedule != null) {
//       data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
//
// /// `copyWith` method
// EmployeeModelData copyWith({
//   String? sId,
//   String? userName,
//   String? email,
//   String? password,
//   String? phone,
//   String? role,
//   List<String>? languages,
//   List<String>? days,
//   bool? isDeleted,
//   bool? isBlocked,
//   String? createdAt,
//   String? updatedAt,
//   int? iV,
//   List<Schedule>? schedule,
// }) {
//   return EmployeeModelData(
//     sId: sId ?? this.sId,
//     userName: userName ?? this.userName,
//     email: email ?? this.email,
//     password: password ?? this.password,
//     phone: phone ?? this.phone,
//     role: role ?? this.role,
//     languages: languages ?? this.languages,
//     days: days ?? this.days,
//     isDeleted: isDeleted ?? this.isDeleted,
//     isBlocked: isBlocked ?? this.isBlocked,
//     createdAt: createdAt ?? this.createdAt,
//     updatedAt: updatedAt ?? this.updatedAt,
//     iV: iV ?? this.iV,
//     schedule: schedule ?? this.schedule,
//   );
// }
//
//
//
//
// class Schedule {
//   String? date;
//   List<String>? times;
//   String? sId;
//
//   Schedule({this.date, this.times, this.sId});
//
//   Schedule.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     times = json['times'].cast<String>();
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['times'] = this.times;
//     data['_id'] = this.sId;
//     return data;
//   }
// }

class EmployeeModelData {
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? role;
  List<String>? languages;
  List<String>? days;
  List<String>? workSpecialization;

  bool? isDeleted;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;

  // List<Schedule>? schedule;

  EmployeeModelData({
    this.sId,
    this.userName,
    this.email,
    this.password,
    this.phone,
    this.role,
    this.workSpecialization,
    this.languages,
    this.days,
    this.isDeleted,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.iV,
    // this.schedule,
  });

  EmployeeModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    languages = json['languages'].cast<String>();
    days = json['days'].cast<String>();
    isDeleted = json['isDeleted'];
    workSpecialization = json['workSpecialization'].cast<String>();
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    // if (json['schedule'] != null) {
    //   schedule = <Schedule>[];
    //   json['schedule'].forEach((v) {
    //     schedule!.add(Schedule.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['role'] = role;
    data['languages'] = languages;
    data['days'] = days;
    data['isDeleted'] = isDeleted;
    data['isBlocked'] = isBlocked;
    data['workSpecialization'] = this.workSpecialization;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    // if (schedule != null) {
    //   data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  /// `copyWith` method
  EmployeeModelData copyWith({
    String? sId,
    String? userName,
    String? email,
    String? password,
    String? phone,
    String? role,
    List<String>? languages,
    List<String>? days,
    bool? isDeleted,
    bool? isBlocked,
    String? createdAt,
    String? updatedAt,
    int? iV,
    // List<Schedule>? schedule,
  }) {
    return EmployeeModelData(
      sId: sId ?? this.sId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      languages: languages ?? this.languages,
      days: days ?? this.days,
      isDeleted: isDeleted ?? this.isDeleted,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iV: iV ?? this.iV,
      // schedule: schedule ?? this.schedule,
    );
  }
}
