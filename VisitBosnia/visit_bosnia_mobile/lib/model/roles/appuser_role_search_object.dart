import '../appUser/app_user.dart';
import 'role.dart';

class AppUserRoleSearchObject {
  int? appUserId;
  int? roleId;
  bool? includeRole;

  AppUserRoleSearchObject({this.appUserId, this.includeRole, this.roleId});

  AppUserRoleSearchObject.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    roleId = json['roleId'];
    includeRole = json['includeRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['roleId'] = this.roleId;
    data['includeRole'] = this.includeRole;
    return data;
  }
}
