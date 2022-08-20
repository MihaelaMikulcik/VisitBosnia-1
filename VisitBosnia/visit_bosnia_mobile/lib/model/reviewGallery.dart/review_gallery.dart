import '../review/review.dart';

class ReviewGallery {
  int? id;
  String? imageType;
  String? image;
  int? reviewId;
  Review? review;

  ReviewGallery(
      {this.id, this.imageType, this.reviewId, this.image, this.review});

  ReviewGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageType = json['imageType'];
    reviewId = json['reviewId'];
    image = json['image'];
    // touristFacility = json['touristFacility'];
    review =
        json['review'] != null ? new Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageType'] = this.imageType;
    data['review'] = this.review;
    data['image'] = this.image;
    data['reviewId'] = this.reviewId;
    // data['touristFacility'] = this.touristFacility;
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    return data;
  }
}
