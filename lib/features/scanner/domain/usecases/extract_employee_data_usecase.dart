import 'dart:io';

import '../entities/extracted_employee.dart';
import '../repositories/scanner_repository.dart';

class ExtractEmployeeDataUseCase {
  final ScannerRepository repository;

  ExtractEmployeeDataUseCase(
    this.repository,
  );

  Future<ExtractedEmployee> call(
    File image,
  ) {
    return repository.extractEmployeeData(
      image,
    );
  }
}