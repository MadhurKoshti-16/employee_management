import 'dart:io';

import '../../domain/entities/extracted_employee.dart';
import '../../domain/repositories/scanner_repository.dart';
import '../datasources/scanner_local_datasource.dart';

class ScannerRepositoryImpl
    implements ScannerRepository {
  final ScannerLocalDataSource localDataSource;

  ScannerRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<ExtractedEmployee> extractEmployeeData(
    File image,
  ) {
    return localDataSource.extractEmployeeData(
      image,
    );
  }
}