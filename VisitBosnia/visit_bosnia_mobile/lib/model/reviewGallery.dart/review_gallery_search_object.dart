class ReviewGallerySearchObject {
  int? reviewId;

  ReviewGallerySearchObject({this.reviewId});

  ReviewGallerySearchObject.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = this.reviewId;
    return data;
  }
}
