class GalleryModel {
  String? status;
  String? message;
  List<GalleryModelData>? result;

  GalleryModel({this.status, this.message, this.result});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <GalleryModelData>[];
      json['result'].forEach((v) {
        result!.add(  GalleryModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryModelData {
  String? sId;
  String? customId;
  String? galleryTitle;
  String? galleryDescription;
  String? gallaryAuthorType;
  List<GalleryImages>? galleryImages;
  String? createdBy;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? updatedBy;

  GalleryModelData(
      {this.sId,
        this.customId,
        this.galleryTitle,
        this.galleryDescription,
        this.gallaryAuthorType,
        this.galleryImages,
        this.createdBy,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.updatedBy});

  GalleryModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customId = json['customId'];
    galleryTitle = json['galleryTitle'];
    galleryDescription = json['galleryDescription'];
    gallaryAuthorType = json['gallaryAuthorType'];
    if (json['galleryImages'] != null) {
      galleryImages = <GalleryImages>[];
      json['galleryImages'].forEach((v) {
        galleryImages!.add(new GalleryImages.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customId'] = customId;
    data['galleryTitle'] = galleryTitle;
    data['galleryDescription'] = galleryDescription;
    data['gallaryAuthorType'] = gallaryAuthorType;
    if (galleryImages != null) {
      data['galleryImages'] =
          galleryImages!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = createdBy;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['updatedBy'] = updatedBy;
    return data;
  }
}

class GalleryImages {
  String? imageUrl;
  String? imageDate;
  String? sId;

  GalleryImages({this.imageUrl, this.imageDate, this.sId});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    imageDate = json['imageDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['imageDate'] = imageDate;
    data['_id'] = sId;
    return data;
  }
}
