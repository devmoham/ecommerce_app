part of 'auth_cubit.dart';

class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDone extends AuthState {
  const AuthDone();
}

final class AuthError extends AuthState {
  final String errorMassage;
  const AuthError(this.errorMassage);
}

final class AuthLoggingOut extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class AuthLogOutError extends AuthState {
  final String errorMassage;
  AuthLogOutError(this.errorMassage);
}

final class GoogleAuthenticating extends AuthState {
  const GoogleAuthenticating();
}

final class GoogleAuthError extends AuthState {
  final String message;

  const GoogleAuthError(this.message);
}

final class GoogleAuthDone extends AuthState {
  const GoogleAuthDone();
}

