import '../../domain/entities/extracted_employee.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class ExtractedEmployeeModel extends ExtractedEmployee {
  const ExtractedEmployeeModel({
    super.employeeId,
    super.name,
    super.department,
    super.designation,
    super.email,
    super.phone,
  });

  factory ExtractedEmployeeModel.fromText(String text) {
    final emailRegex = RegExp(
      r'[\w\.-]+@[\w\.-]+\.\w+',
    );

    final phoneRegex = RegExp(
      r'(?:\+91[\s-]?)?[6-9]\d{9}',
    );

    final employeeIdRegex = RegExp(
      r'\b(?:EMPLOYEE ID|EMP ID|EMP|ID)\b[:\s-]*([A-Z0-9]+)',
      caseSensitive: false,
    );

    final email = emailRegex.firstMatch(text)?.group(0);
    final phone = phoneRegex.firstMatch(text)?.group(0);
    final employeeId = employeeIdRegex.firstMatch(text)?.group(1);

    return ExtractedEmployeeModel(
      employeeId: employeeId,
      email: email,
      phone: phone,
      name: _extractValue(text, [AppStrings.name, 'Employee Name']),
      department: _extractValue(text, [AppStrings.department, 'Dept']),
      designation: _extractValue(text, [AppStrings.designation, 'Role', 'Position']),
    );
  }

  static String? _extractValue(
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