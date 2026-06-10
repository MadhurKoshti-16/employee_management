import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../model/extracted_employee_model.dart';

class ScannerLocalDataSource {
  final TextRecognizer _textRecognizer =
      TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  Future<ExtractedEmployeeModel> extractEmployeeData(
    File image,
  ) async {
    final inputImage =
        InputImage.fromFile(image);


    final recognizedText =
        await _textRecognizer.processImage(
      inputImage,
    );

    return ExtractedEmployeeModel.fromText(
      recognizedText.text,
    );
  }

  Future<void> dispose() async {
    await _textRecognizer.close();
  }
}