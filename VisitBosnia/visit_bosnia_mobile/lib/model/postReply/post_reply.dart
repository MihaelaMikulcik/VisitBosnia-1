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
  // Null? forum;

  PostReply({
    this.id,
    this.appUserId,
    this.postId,
    this.createdTime,
    this.post,
    this.content,
    this.appUser,
    // this.forum
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
    // appUser = json['appUser'];
    // forum = json['forum'];
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
    // data['appUser'] = this.appUser;
    // data['forum'] = this.forum;
    return data;
  }
}
