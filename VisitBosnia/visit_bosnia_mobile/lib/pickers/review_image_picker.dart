import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';

import '../utils/util.dart';

class ReviewImagePicker extends StatefulWidget {
  ReviewImagePicker(
      {Key? key, required this.imagePickFn, required this.isProfile})
      : super(key: key);
  final void Function(File pickedImage) imagePickFn;
  bool isProfile = false;

  @override
  State<ReviewImagePicker> createState() => _ReviewImagePickerState();
}

class _ReviewImagePickerState extends State<ReviewImagePicker> {
  File? imageFile;
  bool isProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final isProfile = widget.isProfile;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => imageFile = imageTemporary);
      widget.imagePickFn(imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget imageBottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Choose profile photo", style: TextStyle(fontSize: 20.0)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera")),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }

  ImageProvider<Object>? setBackgroundImage(bool isProfile) {
    if (imageFile != null) {
      return FileImage(imageFile!);
    } else if (isProfile == true && AppUserProvider.userData.image != "") {
      return imageFromBase64String(AppUserProvider.userData.image as String)
          .image;
    } else {
      return Image.asset("assets/images/plus.jpg").image;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isProfile = widget.isProfile;
    return SizedBox(
      height: 90,
      width: 90,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: setBackgroundImage(isProfile),
            backgroundColor: const Color.fromARGB(255, 123, 179, 231),
          ),
          Positioned(
            bottom: 0,
            right: -20,
            child: RawMaterialButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => imageBottomSheet()));
              },
              elevation: 2.0,
              fillColor: Colors.blue,
              padding: const EdgeInsets.all(10.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
