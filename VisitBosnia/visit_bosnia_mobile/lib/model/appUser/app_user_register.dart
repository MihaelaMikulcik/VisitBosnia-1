class AppUserRegisterRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? userName;
  String? password;
  String? passwordConfirm;
  String? image;

  AppUserRegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.password,
    this.passwordConfirm,
    this.image,
  });

  AppUserRegisterRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
    passwordConfirm = json['passwordConfirm'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['passwordConfirm'] = this.passwordConfirm;
    data['image'] = this.image;
    return data;
  }
}
