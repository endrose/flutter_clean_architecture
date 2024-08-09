import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter_clean_architecture/init_depedencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT DEPEDENCIES
  await initDepedencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => servicelocator<AuthBloc>()),
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
      home: const SigninPage(),
    );
  }
}
