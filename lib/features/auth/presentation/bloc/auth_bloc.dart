import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSingUp>(_onAuthSignUp);
  }

  FutureOr<void> _onAuthSignUp(
      AuthSingUp event, Emitter<AuthState> emit) async {
//
    final response = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    response.fold(
        (failure) => emit(AuthFailure(
              failure.message,
            )),
        (user) => emit(AuthSuccess(
              user,
            )));
  }
}
