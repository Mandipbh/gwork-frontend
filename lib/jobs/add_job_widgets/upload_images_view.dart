import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Add some images for your work',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Text('The following fields are optional',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          Expanded(
            child: Consumer<UploadImageProvider>(
              builder: (BuildContext context, value, Widget? child) {
                print("value.imageList ${value.imageList}");
                return GridView.builder(
                  itemCount: value.imageList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    return value.imageList[index] == "add"
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: UploadImage(),
                                    ),
                                  );
                                },
                              );
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.44,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Upload Photo'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .apply(color: primaryColor),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Image.asset(
                                          'assets/images/upload_image.png',
                                          height: 100,
                                          width: 100),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(value.imageList[index]),
                              fit: BoxFit.cover,
                            ),
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UploadImageProvider extends ChangeNotifier {
  List<String> _imageList = ["add"];
  List<String> get imageList => _imageList;

  getimage(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    _imageList.add(image!.path);

    notifyListeners();
  }

  clearImage() {
    notifyListeners();
  }
}

class UploadImage extends StatelessWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset("assets/icons/upload.png",
              height: 24, width: 24, color: primaryColor),
        ),
        const SizedBox(height: 14),
        const Text(
          'Upload Image',
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: 'Manrope'),
        ),
        const SizedBox(height: 35),
        Consumer<UploadImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return GestureDetector(
              onTap: () {
                value.getimage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Upload from camera'.toUpperCase(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Satoshi'),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/camera-plus.png',
                      height: 24, width: 24),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        Consumer<UploadImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return GestureDetector(
              onTap: () {
                value.getimage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload from gallery'.toUpperCase(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Satoshi'),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/image-plus.png',
                      height: 24, width: 24),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'CLose'.toUpperCase(),
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Satoshi'),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.close, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
