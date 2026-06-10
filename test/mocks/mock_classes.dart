import 'package:employee_onboarding_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

import 'package:employee_onboarding_app/features/auth/domain/entities/app_user.dart';
import 'package:employee_onboarding_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:employee_onboarding_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:employee_onboarding_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:employee_onboarding_app/features/auth/domain/usecases/register_usecase.dart';


class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSource {}
    
class MockAuthRepository
    extends Mock
    implements AuthRepository {}

class MockLoginUseCase
    extends Mock
    implements LoginUseCase {}

class MockRegisterUseCase
    extends Mock
    implements RegisterUseCase {}

class MockLogoutUseCase
    extends Mock
    implements LogoutUseCase {}

class FakeAppUser extends Fake
    implements AppUser {}