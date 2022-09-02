import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

import '../post/post.dart';

class PostReply {
  int? id;
  int? appUserId;
  int? postId;
  String? createdTime;
  String? content;
  AppUser? appUser;
  Post? post;

  PostReply({
    this.id,
    this.appUserId,
    this.postId,
    this.createdTime,
    this.post,
    this.content,
    this.appUser,
  });

  PostReply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    postId = json['postId'];
    createdTime = json['createdTime'];
    content = json['content'];
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['postId'] = this.postId;
    data['createdTime'] = this.createdTime;
    data['content'] = this.content;
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    return data;
  }
}
