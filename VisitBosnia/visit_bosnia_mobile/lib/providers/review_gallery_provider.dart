import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/reviewGallery.dart/review_gallery.dart';

class ReviewGalleryProvider extends BaseProvider<ReviewGallery> {
  ReviewGalleryProvider() : super("ReviewGallery");

  @override
  fromJson(data) {
    // TODO: implement fromJson
    return ReviewGallery.fromJson(data);
  }
}
