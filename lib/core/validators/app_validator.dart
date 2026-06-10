class AppValidator {
  static final _phoneRegex = RegExp(r'^\d{10}$');
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter valid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Minimum 6 characters';
    }

    return null;
  }

  static String? confirmPassword({
    required String password,
    required String? value,
  }) {
    if (value != password) {
      return 'Password does not match';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone Number is required';
    }

    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Enter valid Phone Number';
    }

    return null;
  }
}
