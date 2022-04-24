import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';
import 'package:instgramclone/services/bloc/auth_provider.dart';
import 'package:instgramclone/services/bloc/auth_state.dart';
import 'package:instgramclone/services/bloc/auth_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = await provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
            user: user, isLoading: false));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while registering in',
      ));
      final username = event.username;
      final email = event.email;
      final password = event.password;
      final bio = event.bio;
      final file = event.file;
      try {
        await provider.createUser(
          email: email,
          password: password,
          username: username,
          bio: bio,
          file: file,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });

    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      if (email == null) {
        return;
      }
      emit(const AuthStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: true,
      ));
      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }
      emit(AuthStateForgotPassword(
        exception: exception,
        hasSentEmail: didSendEmail,
        isLoading: false,
      ));
    });

    on<AuthEventShouldRegister>(
      (event, emit) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        emit(const AuthStateRegistering(exception: null, isLoading: false));
      },
    );

    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while logging in',
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);

        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      await provider.initialize();
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
