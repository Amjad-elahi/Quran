part of 'auth_cubit.dart';

// managing state
@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class SuccessState extends AuthState {}

final class ErrorState extends AuthState {
  final String msg;
  ErrorState({required this.msg});
}

final class PassVisibilityState extends AuthState {
  final bool isVisible;
  PassVisibilityState({required this.isVisible});
}

