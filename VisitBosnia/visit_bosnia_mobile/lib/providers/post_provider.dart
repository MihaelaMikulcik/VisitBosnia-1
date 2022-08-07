import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/post/post.dart';

class PostProvider extends BaseProvider<Post> {
  PostProvider() : super("Post");

  @override
  Post fromJson(data) {
    // TODO: implement fromJson
    return Post.fromJson(data);
  }
}
