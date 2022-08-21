class PostReplySearchObject {
  int? appUserId;
  int? postId;
  bool? includeAppUser;

  PostReplySearchObject({this.appUserId, this.postId, this.includeAppUser});

  PostReplySearchObject.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    postId = json['postId'];
    includeAppUser = json['includeAppUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['postId'] = this.postId;
    data['includeAppUser'] = this.includeAppUser;
    return data;
  }
}
