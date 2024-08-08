import 'package:either_dart/src/either.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) {
    return authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
