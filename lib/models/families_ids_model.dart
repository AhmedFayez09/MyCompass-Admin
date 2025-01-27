class FamiliesIdsModel {
  String? status;
  String? message;
  List<FamiliesIdsModelData>? result;

  FamiliesIdsModel({this.status, this.message, this.result});

  FamiliesIdsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <FamiliesIdsModelData>[];
      json['result'].forEach((v) {
        result!.add(new FamiliesIdsModelData.fromJson(v));
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

class FamiliesIdsModelData {
  String? sId;

  FamiliesIdsModelData({this.sId});

  FamiliesIdsModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    return data;
  }
}
