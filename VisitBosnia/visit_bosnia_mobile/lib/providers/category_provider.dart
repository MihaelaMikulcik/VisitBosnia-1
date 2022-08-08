import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/category.dart';

class CategoryProvider extends BaseProvider<Category> {
  CategoryProvider() : super("Category");

  @override
  Category fromJson(data) {
    // TODO: implement fromJson
    return Category.fromJson(data);
  }
}
