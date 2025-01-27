class MaintenanceModel {
  String? status;
  String? message;
  List<MaintenanceModelData>? result;

  MaintenanceModel({this.status, this.message, this.result});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <MaintenanceModelData>[];
      json['result'].forEach((v) {
        result!.add(  MaintenanceModelData.fromJson(v));
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

class MaintenanceModelData {
  String? sId;
  String? categoryName;
  String? maintenanceDescription;
  String? priority;
  String? maintenanceOrderStatuses;
  String? createdBy;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? maintenanceImage;

  String? feedbackComment;

  MaintenanceModelData(
      {this.sId,
        this.categoryName,
        this.maintenanceDescription,
        this.priority,
        this.maintenanceOrderStatuses,
        this.createdBy,
        this.isDeleted,
        this.createdAt,
        this.maintenanceImage,
        this.updatedAt,
        this.feedbackComment,
        this.iV});

  MaintenanceModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    maintenanceDescription = json['maintenanceDescription'];
    priority = json['Priority'];
    maintenanceOrderStatuses = json['maintenanceOrderStatuses'];
    createdBy = json['createdBy'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    maintenanceImage = json['maintenanceImage'];
    updatedAt = json['updatedAt'];
    feedbackComment = json['feedbackComment'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['maintenanceDescription'] = maintenanceDescription;
    data['Priority'] = priority;
    data['maintenanceOrderStatuses'] = maintenanceOrderStatuses;
    data['createdBy'] = createdBy;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['maintenanceImage'] = this.maintenanceImage;
    data['feedbackComment'] = feedbackComment;
    data['__v'] = iV;
    return data;
  }
}
