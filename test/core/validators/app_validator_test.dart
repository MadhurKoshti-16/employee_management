import 'package:employee_onboarding_app/core/validators/app_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group(
    'Email Validator',
    () {

      test(
        'returns null for valid email',
        () {
          expect(
            AppValidator.email(
              'test@test.com',
            ),
            null,
          );
        },
      );

      test(
        'returns error for invalid email',
        () {
          expect(
            AppValidator.email(
              'abc',
            ),
            'Enter valid email',
          );
        },
      );
    },
  );
}