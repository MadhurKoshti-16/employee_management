import 'dart:io';

import '../entities/extracted_employee.dart';

abstract class ScannerRepository {
  Future<ExtractedEmployee> extractEmployeeData(
    File image,
  );
}