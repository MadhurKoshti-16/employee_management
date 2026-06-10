import '../../domain/entities/app_user.dart';

class AuthState {
  final bool isLoading;
  final AppUser? user;
  final String? message;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.message,
  });

  AuthState copyWith({
    bool? isLoading,
    AppUser? user,
    String? message,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      message: message,
    );
  }

  factory AuthState.initial() {
    return const AuthState();
  }
}