import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/commons/widgets/loader.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/core/utils/show_snackbar.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }

            if (state is AuthSuccess) {
              showSnackbar(context, state.user.name);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        AuthField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        AuthField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        AuthField(
                          controller: passwordController,
                          hintText: "Password",
                          isObsecure: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        AuthButton(
                          text: "Sign Up",
                          onTap: () {
                            // print("SignUp  buton clicked");
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthSingUp(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text));
                            }

                            // TODO: SAVE USER DATA
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninPage(),
                                ));
                          },
                          child: RichText(
                              text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}

class SiginPage {
  const SiginPage();
}
