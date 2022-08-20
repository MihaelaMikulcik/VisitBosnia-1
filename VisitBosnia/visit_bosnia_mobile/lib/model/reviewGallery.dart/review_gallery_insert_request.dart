class ReviewGalleryInsertRequest {
  int? reviewId;
  String? image;

  ReviewGalleryInsertRequest({this.reviewId});

  ReviewGalleryInsertRequest.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = this.reviewId;
    data['image'] = this.image;
    return data;
  }
}
