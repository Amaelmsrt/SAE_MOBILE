import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageConverter {
  
  static Future<String> xFileToBase64(XFile file) async {
    File imageFile = File(file.path);
    List<int> imageBytes = await imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}