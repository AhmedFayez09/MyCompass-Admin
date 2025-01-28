class NonResponsedModel {
  String? status;
  String? message;
  List<NonRespondedUsers>? nonRespondedUsers;
  List<NonRespondedUsers>? nonRespondedEmployees;

  NonResponsedModel(
      {this.status,
        this.message,
        this.nonRespondedUsers,
        this.nonRespondedEmployees});

  NonResponsedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['nonRespondedUsers'] != null) {
      nonRespondedUsers = <NonRespondedUsers>[];
      json['nonRespondedUsers'].forEach((v) {
        nonRespondedUsers!.add(new NonRespondedUsers.fromJson(v));
      });
    }
    if (json['nonRespondedEmployees'] != null) {
      nonRespondedEmployees = <NonRespondedUsers>[];
      json['nonRespondedEmployees'].forEach((v) {
        nonRespondedEmployees!.add(new NonRespondedUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.nonRespondedUsers != null) {
      data['nonRespondedUsers'] =
          this.nonRespondedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.nonRespondedEmployees != null) {
      data['nonRespondedEmployees'] =
          this.nonRespondedEmployees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NonRespondedUsers {
  String? sId;
  String? userName;
  String? id;

  NonRespondedUsers({this.sId, this.userName, this.id});

  NonRespondedUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['id'] = this.id;
    return data;
  }
}

