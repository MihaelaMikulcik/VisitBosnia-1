import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/city/city.dart';
import '../model/review/review_insert_request.dart';
import '../model/reviewGallery.dart/review_gallery_insert_request.dart';
import '../model/tourist_facility.dart';
import '../providers/appuser_provider.dart';
import '../providers/review_gallery_provider.dart';
import '../providers/review_provider.dart';
import '../utils/util.dart';
import 'city_facility.dart';

class AddReview extends StatefulWidget {
  // static const String routeName = "/addReview";

  AddReview(this.facility, {Key? key}) : super(key: key);

  TouristFacility facility;

  @override
  State<AddReview> createState() => _AddReviewState(facility);
}

class _AddReviewState extends State<AddReview> {
  _AddReviewState(this.facility);

  TouristFacility facility;

  // late AppUserProvider _appUserProvider;
  late ReviewProvider _reviewProvider;
  late ReviewGalleryProvider _reviewGalleryProvider;

  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _appUserProvider = context.read<AppUserProvider>();
    _reviewProvider = context.read<ReviewProvider>();
    _reviewGalleryProvider = context.read<ReviewGalleryProvider>();
  }

  void _submitReview() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        var request = new ReviewInsertRequest();
        request.appUserId = AppUserProvider.userData.id;
        if (_ratingController.text == "") {
          request.rating = 3;
        } else {
          request.rating = int.parse(_ratingController.text);
        }

        request.text = _contentController.text;
        request.touristFacilityId = facility.id;
        try {
          var newReview = await _reviewProvider.insert(request);
          if (_imageFileList.isNotEmpty) {
            for (var image in _imageFileList) {
              var galleryRequest = new ReviewGalleryInsertRequest();
              galleryRequest.reviewId = newReview!.id!;
              galleryRequest.image = base64String(await image.readAsBytes());
              await _reviewGalleryProvider.insert(galleryRequest);
            }
          }
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    Text(
                      " Thank you for your review!",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ],
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color.fromARGB(255, 3, 131, 78)));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Something went wrong...",
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: const Color.fromARGB(255, 165, 46, 37)));
        }
        // _ratingController.clear();
        // _contentController.clear();
        // _imageFileList.length = 0;
        // setState(() {});
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 76, 120, 1),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("New Review",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
              Icon(
                Icons.reviews_outlined,
                size: 30,
              ),
            ]),
            Divider(
              thickness: 3,
            ),
            buildCreateForm()
          ]),
        )));
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFileList.addAll(selectedImages);
      });
    }
  }

  Widget buildCreateForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text("Write your review:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _txtContent(),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 50.0, left: 10),
          //   child: Text("How would you rate your experience?",
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          // ),
          Align(
            alignment: Alignment.center,
            child: _ratingSection(),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Share some photos of your visit",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         color: Color.fromRGBO(83, 109, 254, 1), width: 4.0),
              //     shape: BoxShape.circle),
              child: OutlinedButton(
                child: Text(
                  "+ add photos",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  selectImages();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _imageFileList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(File(_imageFileList[index].path),
                      fit: BoxFit.cover);
                }),
          ),
          Visibility(
              visible: !_isLoading,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _submitReview();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 75, 70),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Submit review",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ))),
          Visibility(
            visible: _isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }

  bool _autovalidate = false;

  Widget _txtContent() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        controller: _contentController,
        keyboardType: TextInputType.text,
        minLines: 3,
        maxLines: 3,
        onChanged: (_) {
          setState(() {
            _autovalidate = true;
          });
        },
        autovalidateMode:
            _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            hintText: 'Would you like to write anything about this facility?',
            errorStyle: TextStyle(height: 0),
            // hintText: "Write your post here...",
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              // borderRadius: BorderRadius.circular(20.0)
            )));
  }

  Widget _ratingSection() {
    return (RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (rating) {
          int rat = rating.toInt();
          controller:
          _ratingController;
          _ratingController.text = rat.toString();
        }));
  }
}
