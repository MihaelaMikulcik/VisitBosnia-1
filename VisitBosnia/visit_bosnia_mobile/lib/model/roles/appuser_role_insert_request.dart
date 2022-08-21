import '../appUser/app_user.dart';

class AppUserRoleInsertRequest {
  int? appUserId;
  int? roleId;
  bool? includeRole;
  AppUserRoleInsertRequest({this.appUserId, this.roleId});

  AppUserRoleInsertRequest.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['roleId'] = this.roleId;

    return data;
  }
}
