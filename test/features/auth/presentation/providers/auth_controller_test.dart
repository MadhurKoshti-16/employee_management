import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:employee_onboarding_app/features/auth/domain/entities/app_user.dart';
import 'package:employee_onboarding_app/features/auth/presentation/providers/auth_providers.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockLoginUseCase loginUseCase;
  late MockRegisterUseCase registerUseCase;
  late MockLogoutUseCase logoutUseCase;

  late ProviderContainer container;

  setUp(() {
    loginUseCase = MockLoginUseCase();
    registerUseCase = MockRegisterUseCase();
    logoutUseCase = MockLogoutUseCase();

    container = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWith(
          (ref) => loginUseCase,
        ),
        registerUseCaseProvider.overrideWith(
          (ref) => registerUseCase,
        ),
        logoutUseCaseProvider.overrideWith(
          (ref) => logoutUseCase,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'login success updates state',
    () async {
      const user = AppUser(
        uid: '1',
        email: 'test@test.com',
      );

      when(
        () => loginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => user,
      );

      final controller =
          container.read(
        authControllerProvider.notifier,
      );

      await controller.login(
        email: 'test@test.com',
        password: '123456',
      );

      final state =
          container.read(
        authControllerProvider,
      );

      expect(
        state.user?.email,
        'test@test.com',
      );

      expect(
        state.message,
        'Login successful',
      );
    },
  );
}