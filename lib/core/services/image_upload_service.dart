import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (file == null) {
      return null;
    }

    return File(file.path);
  }

  Future<String?> validateImage(
    File image,
  ) async {
    final fileSize =
        await image.length();

    final sizeInMb =
        fileSize / (1024 * 1024);

    if (sizeInMb > 2) {
      return 'Image size must be less than 2 MB';
    }

    final extension =
        image.path
            .split('.')
            .last
            .toLowerCase();

    if (![
      'jpg',
      'jpeg',
      'png',
    ].contains(extension)) {
      return 'Only JPG, JPEG and PNG images are allowed';
    }

    return null;
  }
}