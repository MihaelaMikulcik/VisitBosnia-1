class AppUserUpdateRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? userName;
  String? image;
  String? phone;
  bool? changedUsername;
  bool? changedEmail;

  AppUserUpdateRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.userName,
      this.image,
      this.phone,
      this.changedUsername,
      this.changedEmail});

  AppUserUpdateRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    userName = json['userName'];
    image = json['image'];
    phone = json['phone'];
    changedUsername = json['changedUsername'];
    changedEmail = json['changedEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['changedUsername'] = this.changedUsername;
    data['changedEmail'] = this.changedEmail;

    return data;
  }
}
