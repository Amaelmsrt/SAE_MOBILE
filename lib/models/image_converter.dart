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

  static Future<XFile> base64ToXFile(String base64String) async {
    Uint8List bytes = base64Decode(base64String);

    // Get temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create a temporary file with a unique name
    File tempFile = await File('$tempPath/temp_${DateTime.now().millisecondsSinceEpoch}.png').create();
    await tempFile.writeAsBytes(bytes);

    return XFile(tempFile.path);
  }

}
