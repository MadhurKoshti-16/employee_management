import 'package:employee_onboarding_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_classes.dart';
void main() {
  late MockAuthRepository repository;
  late LogoutUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = LogoutUseCase(repository);
  });

  test(
    'should logout user',
    () async {
      when(
        () => repository.logout(),
      ).thenAnswer(
        (_) async {},
      );

      await useCase();

      verify(
        () => repository.logout(),
      ).called(1);
    },
  );
}