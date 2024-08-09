import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Form(
            key: formKey,
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
            ),
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
          )
        ]),
      ),
    );
  }
}
