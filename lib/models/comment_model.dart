class CommentModel {
  String? status;
  String? message;
  List<CommentModelData>? comments;

  CommentModel({this.status, this.message, this.comments});

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['comments'] != null) {
      comments = <CommentModelData>[];
      json['comments'].forEach((v) {
        comments!.add(new CommentModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentModelData {
  String? sId;
  String? author;
  String? commentContent;
  String? postId;
  List<CommentModelDataReply>? reply;
  String? createdBy;
  String? createdByModel;
  bool? isDeleted;
  // List<Null>? likes;
  // List<Null>? unlikes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CommentModelData(
      {this.sId,
        this.author,
        this.commentContent,
        this.postId,
        this.reply,
        this.createdBy,
        this.createdByModel,
        this.isDeleted,
        // this.likes,
        // this.unlikes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CommentModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    commentContent = json['commentContent'];
    postId = json['postId'];
    if (json['reply'] != null) {
      reply = <CommentModelDataReply>[];
      json['reply'].forEach((v) {
        reply!.add(new CommentModelDataReply.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdByModel = json['createdByModel'];
    isDeleted = json['isDeleted'];
    // if (json['likes'] != null) {
    //   likes = <Null>[];
    //   json['likes'].forEach((v) {
    //     likes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['unlikes'] != null) {
    //   unlikes = <Null>[];
    //   json['unlikes'].forEach((v) {
    //     unlikes!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['commentContent'] = this.commentContent;
    data['postId'] = this.postId;
    if (this.reply != null) {
      data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = this.createdBy;
    data['createdByModel'] = this.createdByModel;
    data['isDeleted'] = this.isDeleted;
    // if (this.likes != null) {
    //   data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    // }
    // if (this.unlikes != null) {
    //   data['unlikes'] = this.unlikes!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CommentModelDataReply {
  String? sId;
  String? author;
  String? commentContent;
  String? postId;
  // List<Null>? reply;
  String? createdBy;
  String? createdByModel;
  bool? isDeleted;
  // List<Null>? likes;
  // List<Null>? unlikes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CommentModelDataReply(
      {this.sId,
        this.author,
        this.commentContent,
        this.postId,
        // this.reply,
        this.createdBy,
        this.createdByModel,
        this.isDeleted,
        // this.likes,
        // this.unlikes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CommentModelDataReply.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    commentContent = json['commentContent'];
    postId = json['postId'];
    // if (json['reply'] != null) {
    //   reply = <Null>[];
    //   json['reply'].forEach((v) {
    //     reply!.add(new Null.fromJson(v));
    //   });
    // }
    createdBy = json['createdBy'];
    createdByModel = json['createdByModel'];
    isDeleted = json['isDeleted'];
    // if (json['likes'] != null) {
    //   likes = <Null>[];
    //   json['likes'].forEach((v) {
    //     likes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['unlikes'] != null) {
    //   unlikes = <Null>[];
    //   json['unlikes'].forEach((v) {
    //     unlikes!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['commentContent'] = this.commentContent;
    data['postId'] = this.postId;
    // if (this.reply != null) {
    //   data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    // }
    data['createdBy'] = this.createdBy;
    data['createdByModel'] = this.createdByModel;
    data['isDeleted'] = this.isDeleted;
    // if (this.likes != null) {
    //   data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    // }
    // if (this.unlikes != null) {
    //   data['unlikes'] = this.unlikes!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
