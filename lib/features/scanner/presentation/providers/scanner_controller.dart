import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../../employee/domain/entities/employee.dart';
import 'scanner_state.dart';

class ScannerController extends Notifier<ScannerState> {
  final ImagePicker _picker = ImagePicker();

  @override
  ScannerState build() {
    return ScannerState.initial();
  }

  Future<Employee?> pickAndExtractFromCamera() async {
    return _pickAndExtract(ImageSource.camera);
  }

  Future<Employee?> pickAndExtractFromGallery() async {
    return _pickAndExtract(ImageSource.gallery);
  }

  void clear() {
  state = ScannerState.initial();
}

  Future<Employee?> _pickAndExtract(ImageSource source) async {
    try {
      state = ScannerState.initial();
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile == null) {
        state = state.copyWith(isLoading: false);
        return null;
      }

      final imageFile = File(pickedFile.path);

      state = state.copyWith(
        selectedImage: imageFile,
      );

      final inputImage = InputImage.fromFile(imageFile);

      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      final recognizedText =
          await textRecognizer.processImage(inputImage);

      await textRecognizer.close();

      final employee = _parseEmployeeData(
        recognizedText.text,
      );

      state = state.copyWith(
        isLoading: false,
      );

      return employee;
    } catch (e, stackTrace) {
       debugPrint(
    'SCAN ERROR => $e',
  );

  debugPrint(
    'SCAN STACK => $stackTrace',
  );
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to scan employee card',
      );

      return null;
    }
  }

  Employee _parseEmployeeData(String text) {
    final email = _extractEmail(text);
    final phone = _extractPhone(text);

    return Employee(
      id: '',
      email: email ?? '',
      phone: phone ?? '',
      employeeId: _extractEmployeeId(text),
      name: _extractName(text),
      department: _extractValue(
        text,
        ['Department', 'Dept'],
      ),
      designation: _extractValue(
        text,
        ['Designation', 'Role', 'Position'],
      ),
    );
  }

  String? _extractEmail(String text) {
    final regex = RegExp(
      r'[\w\.-]+@[\w\.-]+\.\w+',
    );

    return regex.firstMatch(text)?.group(0);
  }

  String? _extractPhone(String text) {
    final regex = RegExp(
      r'(?:\+91[\s-]?)?[6-9]\d{9}',
    );

    return regex.firstMatch(text)?.group(0);
  }

  String? _extractEmployeeId(String text) {
    final regex = RegExp(
      r'(EMP|EMPLOYEE ID|ID)[:\s-]*([A-Z0-9]+)',
      caseSensitive: false,
    );

    return regex.firstMatch(text)?.group(2);
  }

  String? _extractName(String text) {
    return _extractValue(
      text,
      ['Name', 'Employee Name'],
    );
  }

  String? _extractValue(
    String text,
    List<String> keys,
  ) {
    final lines = text.split('\n');

    for (final line in lines) {
      for (final key in keys) {
        if (line.toLowerCase().contains(key.toLowerCase())) {
          final parts = line.split(RegExp(r'[:\-]'));

          if (parts.length > 1) {
            return parts.last.trim();
          }
        }
      }
    }

    return null;
  }
}