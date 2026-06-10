import 'package:employee_onboarding_app/features/auth/data/models/user_model.dart';
import 'package:employee_onboarding_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockAuthRemoteDataSource datasource;
  late AuthRepositoryImpl repository;

  setUp(() {
    datasource =
        MockAuthRemoteDataSource();

    repository =
        AuthRepositoryImpl(
      datasource,
    );
  });

  test(
    'should return user on login',
    () async {

      const model = UserModel(
        uid: '1',
        email: 'test@test.com',
      );

      when(
        () => datasource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => model,
      );

      final result =
          await repository.login(
        email: 'test@test.com',
        password: '123456',
      );

      expect(
        result.email,
        'test@test.com',
      );
    },
  );
}