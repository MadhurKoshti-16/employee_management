import 'package:employee_onboarding_app/features/auth/domain/entities/app_user.dart';
import 'package:employee_onboarding_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
  });

  test(
    'should register user',
    () async {
      const user = AppUser(
        uid: '1',
        email: 'new@test.com',
      );

      when(
        () => repository.register(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => user,
      );

      final result = await useCase(
        email: 'new@test.com',
        password: '123456',
      );

      expect(
        result.email,
        'new@test.com',
      );
    },
  );
}