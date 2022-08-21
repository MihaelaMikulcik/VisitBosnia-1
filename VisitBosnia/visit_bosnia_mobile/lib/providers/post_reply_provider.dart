import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/postReply/post_reply.dart';

class PostReplyProvider extends BaseProvider<PostReply> {
  PostReplyProvider() : super("PostReply");

  @override
  PostReply fromJson(data) {
    // TODO: implement fromJson
    return PostReply.fromJson(data);
  }
}
