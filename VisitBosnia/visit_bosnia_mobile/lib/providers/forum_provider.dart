import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/forum/forum.dart';

class ForumProvider extends BaseProvider<Forum> {
  ForumProvider() : super("Forum");

  @override
  Forum fromJson(data) {
    // TODO: implement fromJson
    return Forum.fromJson(data);
  }
}
