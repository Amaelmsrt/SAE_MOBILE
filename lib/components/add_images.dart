import 'dart:io';

import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatefulWidget {
  List<XFile> images = [];

  ValueNotifier<List<XFile>> valueNotifier;

  AddImages({required this.valueNotifier});

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          widget.images.add(image);
          widget.valueNotifier.value = widget.images;
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ajouter des images",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "NeueRegrade",
            )),
        SizedBox(height: 16),
        Container(
          alignment: Alignment.center,
          height: 100,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var image in widget.images)
                Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.file(
                            File(image.path),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.images.remove(image);
                              });
                            },
                            child: Container(
                              height: 25, // same height as a FAB
                              width: 25, // same width as a FAB
                              decoration: BoxDecoration(
                                color:
                                    AppColors.primary, // same color as your FAB
                                borderRadius: BorderRadius.circular(
                                    8000), // change this to your desired border radius
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/cross.svg",
                                  width: 10,
                                  height: 10,
                                ), // your icon
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              if (widget.images.isEmpty)
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accent, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset("assets/icons/img-upload.svg"),
                        SizedBox(
                          width: 12,
                        ),
                        Text("Ajouter une image",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NeueRegrade",
                                color: AppColors.accent))
                      ],
                    ),
                  ),
                ),
              if (widget.images.isNotEmpty && widget.images.length < 4)
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accent, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/img-upload.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                )
            ],
          )),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
