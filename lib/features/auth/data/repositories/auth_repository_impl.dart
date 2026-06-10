import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl
    implements AuthRepository {
  final AuthRemoteDataSource
      remoteDataSource;

  AuthRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) {
    return remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<AppUser> register({
    required String email,
    required String password,
  }) {
    return remoteDataSource.register(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  AppUser? currentUser() {
    return remoteDataSource.currentUser();
  }
}