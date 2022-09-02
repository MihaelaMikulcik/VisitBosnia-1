// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visit_bosnia_mobile/model/reviewGallery.dart/review_gallery_insert_request.dart';

import 'package:visit_bosnia_mobile/providers/tourist_facility_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../model/appUser/app_user.dart';
import '../model/review/review.dart';
import '../model/review/review_insert_request.dart';
import '../model/review/review_search_object.dart';
import '../model/reviewGallery.dart/review_gallery.dart';
import '../model/reviewGallery.dart/review_gallery_search_object.dart';
import '../model/tourist_facility.dart';
import '../pages/add_review.dart';
import '../pickers/review_image_picker.dart';
import '../pickers/user_image_picker.dart';
import '../providers/appuser_provider.dart';
import '../providers/review_gallery_provider.dart';
import '../providers/review_provider.dart';
import '../providers/tourist_facility_gallery_provider.dart';
import '../utils/util.dart';

class ReviewFacility extends StatefulWidget {
  ReviewFacility(this.touristFacility, {Key? key}) : super(key: key);
  TouristFacility touristFacility;

  @override
  State<ReviewFacility> createState() => _ReviewFacilityState(touristFacility);
}

class _ReviewFacilityState extends State<ReviewFacility> {
  late TouristFacilityProvider _touristFacilityProvider;
  late AppUserProvider _appUserProvider;
  late ReviewProvider _reviewProvider;
  late ReviewGalleryProvider _reviewGalleryProvider;

  TouristFacility touristFacility;
  _ReviewFacilityState(this.touristFacility);

  int one = 0;
  int two = 0;
  int three = 0;
  int four = 0;
  int five = 0;
  double rating = 0;
  int total = 0;

  int perPage = 3;

  late List<Review> originalItems = [];
  late List<Review> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewGalleryProvider = context.read<ReviewGalleryProvider>();
    _touristFacilityProvider = context.read<TouristFacilityProvider>();
    _appUserProvider = context.read<AppUserProvider>();
    _reviewProvider = context.read<ReviewProvider>();
  }

  Future<List<Review>> loadReviews() async {
    var search = ReviewSearchObject(
        facilityId: touristFacility.id!, includeAppUser: true);
    var reviews = await _reviewProvider.get(search.toJson());
    if (reviews.isNotEmpty) {
      setRatings(reviews);
    }
    return reviews;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setRatings(List<Review> reviews) {
    one = reviews.where((element) => element.rating == 1).length;
    two = reviews.where((element) => element.rating == 2).length;
    three = reviews.where((element) => element.rating == 3).length;
    four = reviews.where((element) => element.rating == 4).length;
    five = reviews.where((element) => element.rating == 5).length;
    total = one + two + three + four + five;
    if (total != 0) {
      rating = (one + two * 2 + three * 3 + four * 4 + five * 5) / total;
    }
    _touristFacilityProvider.updateRating(rating.toStringAsFixed(2));
  }

  Future<List<ReviewGallery>> getGallery(int reviewId) async {
    var search = ReviewGallerySearchObject(reviewId: reviewId);
    var gallery = await _reviewGalleryProvider.get(search.toJson());
    return gallery;
  }

  Future<AppUser> getUser(int userId) async {
    var user = await _appUserProvider.getById(userId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10), child: _buildReviewList());
  }

  Widget chartRow(String label, int pct) {
    return Expanded(
        child: Row(
      children: [
        Text(
          label,
        ),
        SizedBox(width: 8),
        Icon(Icons.star, color: Colors.yellow),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
              child: Text(''),
            ),
            Container(
              width: total != 0
                  ? MediaQuery.of(context).size.width * (pct / total) * 0.5
                  : 0,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 211, 75, 70),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(''),
            ),
          ]),
        ),
        Text('$pct'),
      ],
    ));
  }

  Widget buildReviews() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Column(children: [
      Divider(
        thickness: 3,
      ),
      SizedBox(
        height: 50.0,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Reviews ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Icon(
              Icons.reviews_outlined,
              size: 30,
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: queryData.devicePixelRatio * 20, top: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddReview(touristFacility)),
                ).then((value) => setState(() {}));
              },
              label: const Text('Write a review'),
              icon: const Icon(Icons.create_rounded),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  textStyle: const TextStyle(color: Colors.white)),
            ),
          )
        ]),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(total.toString() + " reviews",
            style: TextStyle(
                color: Color.fromARGB(255, 92, 91, 91),
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      Row(children: [
        Container(
          height: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              chartRow('5', five),
              chartRow('4', four),
              chartRow('3', three),
              chartRow('2', two),
              chartRow('1', one),
              SizedBox(height: 8),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: queryData.devicePixelRatio * 10),
          child: Text(
            rating.toStringAsFixed(2),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]),
      Divider(),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("What travelers are saying",
            style: TextStyle(
                color: Color.fromARGB(255, 92, 91, 91),
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
    ]);
  }

  Widget imageContainer(Review review) {
    if (review.appUser!.image != "") {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64Decode(review.appUser!.image!)),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30)));
    } else {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/user3.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30)));
    }
  }

  Widget _reviewCard(Review review) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            imageContainer(review),
            Container(
              height: 100.0,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            review.appUser!.firstName! +
                                " " +
                                review.appUser!.lastName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ),
                  Container(
                    height: 20,
                    padding: EdgeInsets.only(left: 10),
                    child: RatingBarIndicator(
                      rating: review.rating!.toDouble(),
                      itemSize: 25,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(review.text!, style: TextStyle(fontSize: 15)),
            )),
        _buildReviewGallery(review.id!),
      ],
    ));
  }

  _buildReviewList() {
    return FutureBuilder<List<Review>>(
        future: loadReviews(),
        builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.data!.length > 0) {
                return Column(
                  children: [
                    Column(
                      children: [
                        buildReviews(),
                      ],
                    ),
                    Column(
                        children: snapshot.data!
                            .take(perPage)
                            .map((e) => _reviewCard(e))
                            .toList()),
                    (perPage < snapshot.data!.length)
                        ? Container(
                            child: TextButton(
                              child: Text("Load More"),
                              onPressed: () {
                                setState(() {
                                  perPage = perPage + 3;
                                  if ((perPage) > snapshot.data!.length) {
                                    perPage = snapshot.data!.length;
                                  }
                                });
                              },
                            ),
                          )
                        : Container()
                  ],
                );
              } else {
                return Container(child: buildReviews());
              }
            }
          }
        });
  }

  _buildReviewGallery(int reviewId) {
    return FutureBuilder<List<ReviewGallery>>(
        future: getGallery(reviewId),
        builder: (BuildContext context,
            AsyncSnapshot<List<ReviewGallery>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.data!.isNotEmpty) {
                return Container(
                    height: 80.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!
                            .map((e) => buildReviewImage(e))
                            .toList()));
              } else {
                return Divider();
              }
            }
          }
        });
  }

  Widget buildReviewImage(ReviewGallery gallery) {
    return FullScreenWidget(
        child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64Decode(gallery.image!)),
                fit: BoxFit.cover,
              ),
            )));
  }
}
