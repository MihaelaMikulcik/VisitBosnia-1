import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/post/post.dart';
import '../model/roles/Role.dart';

class RoleProvider extends BaseProvider<Role> {
  RoleProvider() : super("Role");

  @override
  Role fromJson(data) {
    // TODO: implement fromJson
    return Role.fromJson(data);
  }
}
