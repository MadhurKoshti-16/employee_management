import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

class AuthController extends Notifier<AuthState> {
  late final LoginUseCase _loginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final LogoutUseCase _logoutUseCase;

  @override
  AuthState build() {
    _loginUseCase = ref.read(
      loginUseCaseProvider,
    );

    _registerUseCase = ref.read(
      registerUseCaseProvider,
    );

    _logoutUseCase = ref.read(
      logoutUseCaseProvider,
    );

    return AuthState.initial();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      final AppUser user =
          await _loginUseCase(
        email: email,
        password: password,
      );

      

      state = state.copyWith(
        isLoading: false,
        user: user,
        message: 'Login successful',
      );

      return true;
    } on AppException catch (e) {
      
      state = state.copyWith(
        isLoading: false,
        message: e.message,
      );

      return false;
    } catch (_) {
      
      state = state.copyWith(
        isLoading: false,
        message: 'Something went wrong',
      );

      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      final AppUser user =
          await _registerUseCase(
        email: email,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        user: user,
        message: 'Registration successful',
      );

      return true;
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: e.message,
      );

      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Something went wrong',
      );

      return false;
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      await _logoutUseCase();

      state = const AuthState(
        user: null,
        message: 'Logout successful',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Unable to logout',
      );
    }
  }

  void clearMessage() {
    state = state.copyWith(
      message: null,
    );
  }
}