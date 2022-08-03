import 'category.dart';
import 'city/city.dart';

class IdNavigation {
  int? id;
  String? name;
  String? description;
  int? cityId;
  int? categoryId;
  Category? category;
  City? city;

  IdNavigation(
      {this.id,
      this.name,
      this.description,
      this.cityId,
      this.categoryId,
      this.category,
      this.city});

  IdNavigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cityId = json['cityId'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['cityId'] = this.cityId;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}
