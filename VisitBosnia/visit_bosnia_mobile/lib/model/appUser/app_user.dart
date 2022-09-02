class AppUser {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? image;
  String? phone;
  String? email;
  bool? isBlocked;

  AppUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.phone,
      this.email,
      this.isBlocked});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    isBlocked = json['isBlocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['isBlocked'] = this.isBlocked;

    return data;
  }
}
