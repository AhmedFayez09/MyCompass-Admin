class IdsModel {
  String? status;
  String? message;
  List<String>? allIds;

  IdsModel({this.status, this.message, this.allIds});

  IdsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allIds = json['allIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['allIds'] = this.allIds;
    return data;
  }
}
