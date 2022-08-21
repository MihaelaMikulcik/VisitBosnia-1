import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class PostReplyInsertRequest {
  int? appUserId;
  int? postId;
  String? createdTime;
  String? content;

  PostReplyInsertRequest({
    this.appUserId,
    this.postId,
    this.createdTime,
    this.content,
  });

  PostReplyInsertRequest.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    postId = json['postId'];
    createdTime = json['createdTime'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['postId'] = this.postId;
    data['createdTime'] = this.createdTime;
    data['content'] = this.content;
    return data;
  }
}
