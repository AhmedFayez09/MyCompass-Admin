class PostsModel {
  String? message;
  List<PostsModelData>? result;

  PostsModel({this.message, this.result});

  PostsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <PostsModelData>[];
      json['result'].forEach((v) {
        result!.add(PostsModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostsModelData {
  String? sId;
  String? postTitle;
  String? postContent;
  String? postImage;
  String? authorType;
  List<Comments>? comments;

  bool? isDeleted;
  List<Likes>? likes;
  List<Likes>? unlikes;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? like;
  bool? unliked;

  PostsModelData(
      {this.sId,
      this.postTitle,
      this.postContent,
      this.authorType,
      this.comments,
      this.createdBy,
      this.isDeleted,
      this.likes,
      this.unlikes,
      this.postImage,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.like,
      this.unliked});

  PostsModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postTitle = json['postTitle'];
    postContent = json['postContent'];
    authorType = json['authorType'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    isDeleted = json['isDeleted'];
    postImage = json['postImage'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['unlikes'] != null) {
      unlikes = <Likes>[];
      json['unlikes'].forEach((v) {
        unlikes!.add(Likes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    like = json['like'];
    unliked = json['unliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['postTitle'] = postTitle;
    data['postContent'] = postContent;
    data['authorType'] = authorType;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['isDeleted'] = isDeleted;
    data['postImage'] = postImage;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (unlikes != null) {
      data['unlikes'] = unlikes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['like'] = like;
    data['unliked'] = unliked;
    return data;
  }
}

class Likes {
  String? userId;
  String? userType;
  String? sId;

  Likes({this.userId, this.userType, this.sId});

  Likes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userType = json['userType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userType'] = userType;
    data['_id'] = sId;
    return data;
  }
}

class Unlikes {
  String? userId;
  String? userType;

  Unlikes({this.userId, this.userType});

  Unlikes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userType'] = userType;
    return data;
  }
}

class Comments {
  String? sId;
  String? author;
  String? commentContent;
  String? postId;
  CreatedBy? createdBy;
  List<Reply>? reply;

  bool? isDeleted;
  List<Likes>? likes;
  List<Unlikes>? unlikes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.sId,
      this.author,
      this.commentContent,
      this.postId,
      this.reply,
      this.createdBy,
      this.isDeleted,
      this.likes,
      this.unlikes,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    commentContent = json['commentContent'];
    postId = json['postId'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(  Reply.fromJson(v));
      });
    }
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    isDeleted = json['isDeleted'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['unlikes'] != null) {
      unlikes = <Unlikes>[];
      json['unlikes'].forEach((v) {
        unlikes!.add(Unlikes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['commentContent'] = commentContent;
    data['postId'] = postId;
    // if (this.reply != null) {
    //   data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    // }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['isDeleted'] = isDeleted;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (unlikes != null) {
      data['unlikes'] = unlikes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}



class Reply {
  String? sId;
  String? author;
  String? commentContent;
  String? postId;
  List<Reply>? reply;
  String? createdBy;
  bool? isDeleted;
  List<Likes>? likes;
  List<Unlikes>? unlikes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reply(
      {this.sId,
        this.author,
        this.commentContent,
        this.postId,
        this.reply,
        this.createdBy,
        this.isDeleted,
        this.likes,
        this.unlikes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Reply.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    commentContent = json['commentContent'];
    postId = json['postId'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(  Reply.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    isDeleted = json['isDeleted'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(  Likes.fromJson(v));
      });
    }
    if (json['unlikes'] != null) {
      unlikes = <Unlikes>[];
      json['unlikes'].forEach((v) {
        unlikes!.add(  Unlikes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['commentContent'] = commentContent;
    data['postId'] = postId;
    if (reply != null) {
      data['reply'] = reply!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = createdBy;
    data['isDeleted'] = isDeleted;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (unlikes != null) {
      data['unlikes'] = unlikes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}



class CreatedBy {
  String? sId;
  String? userName;
  String? email;
  String? phone;

  CreatedBy({this.sId, this.userName, this.email, this.phone});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}