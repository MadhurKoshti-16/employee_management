import 'package:employee_onboarding_app/core/exceptions/firebase_exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test(
    'invalid credential',
    () {

      final exception =
          FirebaseAuthException(
        code:
            'invalid-credential',
      );

      final result =
          FirebaseExceptionMapper.map(
        exception,
      );

      expect(
        result,
        'Invalid email or password',
      );
    },
  );
}