import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';

import '../utils/util.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(
      {Key? key, required this.imagePickFn, required this.isProfile})
      : super(key: key);
  final void Function(File pickedImage) imagePickFn; //dodano
  bool isProfile = false;

  // final ImageProvider<Object>? profileImg;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? imageFile;
  // ImageProvider<Object>? profileImg;
  late AppUserProvider appUserProvider;
  bool isProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final profileImg = widget.profileImg;
    final isProfile = widget.isProfile;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => imageFile = imageTemporary);
      widget.imagePickFn(imageTemporary); // dodano
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

  // ImageProvider<Object>? setBackgroundImage() {
  //   if (imageFile != null) {
  //     return FileImage(imageFile!);
  //   } else {
  //     return const AssetImage("assets/images/user3.jpg")
  //         as ImageProvider<Object>?;
  //   }
  // }
  ImageProvider<Object>? setBackgroundImage(bool isProfile) {
    if (imageFile != null) {
      return FileImage(imageFile!);
    } else if (isProfile == true && appUserProvider.userData.image != "") {
      return imageFromBase64String(appUserProvider.userData.image as String)
          .image;
    } else {
      return Image.asset("assets/images/user3.jpg").image;
      // return const AssetImage("assets/images/user3.jpg")
      //     as ImageProvider<Object>?;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final profileImg = widget.profileImg;
    final isProfile = widget.isProfile;
    appUserProvider = Provider.of<AppUserProvider>(context);
    return SizedBox(
      height: 140,
      width: 140,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            //backgroundImage: AssetImage("assets/images/user.png"),
            backgroundImage: setBackgroundImage(isProfile),
            // backgroundImage: imageFile != null
            //     ? FileImage(imageFile!)
            //     : const AssetImage("assets/images/user3.jpg")
            //         as ImageProvider<Object>?,
            backgroundColor: const Color.fromARGB(255, 123, 179, 231),
            // radius: 70.0,
          ),
          // ClipOval(
          //     child: image != null
          //         ? Image.file(image!)
          //         : const Image(
          //             image: AssetImage("assets/images/user.png"),
          //             height: 150,
          //             width: 150,
          //             fit: BoxFit.cover,
          //           )),
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
