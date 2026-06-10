import 'package:employee_onboarding_app/features/auth/domain/entities/app_user.dart';
import 'package:employee_onboarding_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = LoginUseCase(repository);
  });

  test(
    'should login user successfully',
    () async {
      const user = AppUser(
        uid: '1',
        email: 'test@test.com',
      );

      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => user,
      );

      final result = await useCase(
        email: 'test@test.com',
        password: '123456',
      );

      expect(
        result.email,
        'test@test.com',
      );

      verify(
        () => repository.login(
          email: 'test@test.com',
          password: '123456',
        ),
      ).called(1);
    },
  );
}