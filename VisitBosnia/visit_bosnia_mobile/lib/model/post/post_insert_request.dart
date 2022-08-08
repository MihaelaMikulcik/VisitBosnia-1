import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class PostInsertRequest {
  int? appUserId;
  int? forumId;
  String? createdTime;
  String? title;
  String? content;

  PostInsertRequest({
    this.appUserId,
    this.forumId,
    this.createdTime,
    this.title,
    this.content,
  });

  PostInsertRequest.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    forumId = json['forumId'];
    createdTime = json['createdTime'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['forumId'] = this.forumId;
    data['createdTime'] = this.createdTime;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
