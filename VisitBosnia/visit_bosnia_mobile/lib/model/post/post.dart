import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class Post {
  int? id;
  int? appUserId;
  int? forumId;
  String? createdTime;
  String? title;
  String? content;
  AppUser? appUser;
  // Null? forum;

  Post({
    this.id,
    this.appUserId,
    this.forumId,
    this.createdTime,
    this.title,
    this.content,
    this.appUser,
    // this.forum
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    forumId = json['forumId'];
    createdTime = json['createdTime'];
    title = json['title'];
    content = json['content'];
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
    // appUser = json['appUser'];
    // forum = json['forum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['forumId'] = this.forumId;
    data['createdTime'] = this.createdTime;
    data['title'] = this.title;
    data['content'] = this.content;
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    // data['appUser'] = this.appUser;
    // data['forum'] = this.forum;
    return data;
  }
}
