import 'package:ecommerce_app/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImpl();

  Future<void> loginWithEmailandPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.loginWithEmailandPassword(email, password);
      if (result) {
        emit(const AuthDone());
      } else {
        emit(const AuthError('logined failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithEmailandPassword(
      String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.registerWithEmailandPassword(email, password);
      if (result) {
        emit(const AuthDone());
      } else {
        emit(const AuthError('register failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void chekAuth() {
    final user = authServices.currentUser();
    if (user != null) {
      emit(const AuthDone());
    }
  }

  Future<void> logOut() async {
    emit(AuthLoggingOut());
    try {
      await authServices.signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLogOutError(e.toString()));
    }
  }

    Future<void> authenticateWithGoogle() async {
    emit(const GoogleAuthenticating());
    try {
      final result = await authServices.authenticateWithGoogle();
      if (result) {
        emit(const GoogleAuthDone());
      } else {
        emit(const GoogleAuthError('Google authentication failed'));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }

}
