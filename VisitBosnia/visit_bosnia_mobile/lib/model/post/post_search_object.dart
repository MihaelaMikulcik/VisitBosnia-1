class PostSearchObject {
  String? title;
  int? forumId;
  bool? includeAppUser;

  PostSearchObject({this.title, this.includeAppUser, this.forumId});

  PostSearchObject.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    forumId = json['forumId'];
    includeAppUser = json['includeAppUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['forumId'] = this.forumId;
    data['includeAppUser'] = this.includeAppUser;
    return data;
  }
}
