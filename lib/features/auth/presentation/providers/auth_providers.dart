import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

import 'auth_controller.dart';
import 'auth_state.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authRemoteDatasourceProvider =
    Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    ref.read(firebaseAuthProvider),
  ),
);

final authRepositoryProvider =
    Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(
      authRemoteDatasourceProvider,
    ),
  ),
);

final loginUseCaseProvider =
    Provider<LoginUseCase>(
  (ref) => LoginUseCase(
    ref.read(authRepositoryProvider),
  ),
);

final registerUseCaseProvider =
    Provider<RegisterUseCase>(
  (ref) => RegisterUseCase(
    ref.read(authRepositoryProvider),
  ),
);

final logoutUseCaseProvider =
    Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(
    ref.read(authRepositoryProvider),
  ),
);

final authControllerProvider =
    NotifierProvider<
        AuthController,
        AuthState>(
  AuthController.new,
);