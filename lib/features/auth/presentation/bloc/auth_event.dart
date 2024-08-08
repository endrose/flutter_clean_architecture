part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSingUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSingUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({
    required this.email,
    required this.password,
  });
}
