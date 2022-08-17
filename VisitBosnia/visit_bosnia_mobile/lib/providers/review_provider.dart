import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/review/review.dart';

class ReviewProvider extends BaseProvider<Review> {
  ReviewProvider() : super("Review");

  @override
  Review fromJson(data) {
    // TODO: implement fromJson
    return Review.fromJson(data);
  }
}
