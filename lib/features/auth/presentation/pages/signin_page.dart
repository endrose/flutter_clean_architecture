import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/commons/widgets/loader.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/core/utils/show_snackbar.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
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
                            'Sign In',
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 24,
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
                            hintText: 'Password',
                            isObsecure: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AuthButton(
                            text: "Sign In",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print({
                                  emailController.text.trim(),
                                  passwordController.text
                                });
                                context.read<AuthBloc>().add(AuthSignIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text));
                              }
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
                                    builder: (context) => const SignupPage(),
                                  ));
                            },
                            child: RichText(
                                text: TextSpan(
                              text: "Don't have account yet? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                  text: 'Sign Up',
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
                    )
                  ],
                );
              },
            )));
  }
}

class SiginPage {
  const SiginPage();
}
