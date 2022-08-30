import 'dart:convert';

import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/post/post.dart';

class PostProvider extends BaseProvider<Post> {
  PostProvider() : super("Post");

  @override
  Post fromJson(data) {
    // TODO: implement fromJson
    return Post.fromJson(data);
  }

  void updateReplies(int postId) {
    getNumberOfReplies(postId);
    notifyListeners();
  }

  Future<int> getNumberOfReplies(int postId) async {
    var url = "${BaseProvider.baseUrl}Post/GetNumberOfReplies?postId=$postId";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      // return Attraction.fromJson(data);
      return data;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
