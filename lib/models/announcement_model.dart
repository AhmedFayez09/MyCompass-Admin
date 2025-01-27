class AnnouncementModel {
  String? status;
  String? message;
  int? count;
  List<AnnouncementModelData>? result;

  AnnouncementModel({this.status, this.message, this.count, this.result});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['result'] != null) {
      result = <AnnouncementModelData>[];
      json['result'].forEach((v) {
        result!.add(new AnnouncementModelData.fromJson(v));
      });

      result = result?.reversed.toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['count'] = count;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnnouncementModelData {
  String? sId;
  String? author;
  String? announcementTitle;
  String? announcementDesc;
  String? priority;
  String? type;
  String? date;
  String? time;
  String? createdBy;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? customId;
  String? announcementAttach;

  AnnouncementModelData(
      {this.sId,
      this.author,
      this.announcementTitle,
      this.announcementDesc,
      this.priority,
      this.type,
      this.date,
      this.time,
      this.createdBy,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.customId,
      this.announcementAttach});

  AnnouncementModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    announcementTitle = json['announcementTitle'];
    announcementDesc = json['announcementDesc'];
    priority = json['Priority'];
    type = json['type'];
    date = json['Date'];
    time = json['Time'];
    createdBy = json['createdBy'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    customId = json['customId'];
    announcementAttach = json['announcementAttach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['announcementTitle'] = announcementTitle;
    data['announcementDesc'] = announcementDesc;
    data['Priority'] = priority;
    data['type'] = type;
    data['Date'] = date;
    data['Time'] = time;
    data['createdBy'] = createdBy;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['customId'] = customId;
    data['announcementAttach'] = announcementAttach;
    return data;
  }
}
