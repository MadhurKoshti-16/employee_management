import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

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
      return AppStrings.imageSizeError;
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
      return AppStrings.invalidImageFormat;
    }

    return null;
  }
}