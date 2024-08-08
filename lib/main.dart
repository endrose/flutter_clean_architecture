import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SUPABASE
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.SupabaseKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
            userSignUp: UserSignUp(AuthRepositoryImpl(AuthRemoteDatasourceImp(
          supabase.client,
        )))),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      title: 'Flutter Clean Architecture',
      debugShowCheckedModeBanner: false,
      home: const SignupPage(),
    );
  }
}
