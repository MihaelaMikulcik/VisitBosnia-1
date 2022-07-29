class AppUserUpdateRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? userName;
  String? image;
  String? phone;

  AppUserUpdateRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.userName,
      this.image,
      this.phone});

  AppUserUpdateRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    userName = json['userName'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['phone'] = this.phone;

    return data;
  }
}
