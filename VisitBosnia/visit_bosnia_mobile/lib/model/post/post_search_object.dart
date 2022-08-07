class PostSearchObject {
  String? title;
  int? forumId;

  PostSearchObject({this.title, this.forumId});

  PostSearchObject.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    forumId = json['forumId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['forumId'] = this.forumId;
    return data;
  }
}
