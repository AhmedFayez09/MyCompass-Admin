class GetAllAdminsDataModel {
  String? message;
  List<AllAdmins>? allAdmins;

  GetAllAdminsDataModel({this.message, this.allAdmins});

  GetAllAdminsDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['allAdmins'] != null) {
      allAdmins = <AllAdmins>[];
      json['allAdmins'].forEach((v) {
        allAdmins!.add(new AllAdmins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.allAdmins != null) {
      data['allAdmins'] = this.allAdmins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllAdmins {
  String? sId;
  String? userName;
  String? email;
  String? phone;

  AllAdmins({this.sId, this.userName, this.email, this.phone});

  AllAdmins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
