import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static Future<File?> pickMedia({
    required bool isGallery,
  }) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }

  static Future<String> convertToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}
