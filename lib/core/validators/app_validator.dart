import 'package:employee_onboarding_app/config/app_strings.dart';
class AppValidator {
  static final _phoneRegex = RegExp(r'^\d{10}$');
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }

    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (value.length < 6) {
      return AppStrings.min6Chars;
    }

    return null;
  }

  static String? confirmPassword({
    required String password,
    required String? value,
  }) {
    if (value != password) {
      return AppStrings.passwordNotMatch;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }

    if (!_phoneRegex.hasMatch(value.trim())) {
      return AppStrings.enterValidPhone;
    }

    return null;
  }
}