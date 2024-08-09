import 'package:flutter_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signin.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;

Future<void> initDepedencies() async {
  // SUPABASE
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseKey);

  servicelocator.registerLazySingleton(() => supabase.client);

  // START INIT AUTH
  initAuth();
}

void initAuth() {
  servicelocator
    // DATA SOURCE
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDatasourceImp(servicelocator()))
    // REPOSITORY
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(servicelocator()))
    // USECASE
    ..registerFactory(() => UserSignUp((servicelocator())))
    ..registerFactory(() => UserSignIn((servicelocator())))

    // BLOC
    ..registerFactory(() =>
        AuthBloc(userSignUp: servicelocator(), userSignIn: servicelocator()));

  // END
  ;
}
