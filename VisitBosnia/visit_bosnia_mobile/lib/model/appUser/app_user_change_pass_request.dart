class AppUserChangePasswordRequest {
  String? userName;
  String? oldPassword;
  String? newPassword;
  String? newPasswordConfirm;

  AppUserChangePasswordRequest({
    this.userName,
    this.oldPassword,
    this.newPassword,
    this.newPasswordConfirm,
  });

  AppUserChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    newPasswordConfirm = json['newPasswordConfirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['newPasswordConfirm'] = this.newPasswordConfirm;
    return data;
  }
}
