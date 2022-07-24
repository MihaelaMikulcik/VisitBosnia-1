class AppUser {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? image;

  AppUser({this.id, this.firstName, this.lastName, this.userName, this.image});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['image'] = this.image;

    return data;
  }
}
