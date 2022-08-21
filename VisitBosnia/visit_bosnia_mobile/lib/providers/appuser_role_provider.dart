import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/roles/appuser_role.dart';

class AppUserRoleProvider extends BaseProvider<AppUserRole> {
  AppUserRoleProvider() : super("AppUserRole");

  @override
  AppUserRole fromJson(data) {
    // TODO: implement fromJson
    return AppUserRole.fromJson(data);
  }
}
