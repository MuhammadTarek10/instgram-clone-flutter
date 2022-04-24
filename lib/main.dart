import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgramclone/firebase_options.dart';
import 'package:instgramclone/helpers/loading/loading_screen.dart';
import 'package:instgramclone/providers/user_provider.dart';
import 'package:instgramclone/responsive/mobile_screen_layout.dart';
import 'package:instgramclone/responsive/responsive_screen_layout.dart';
import 'package:instgramclone/responsive/web_screen_layout.dart';
import 'package:instgramclone/screens/login_screen.dart';
import 'package:instgramclone/screens/signup_screen.dart';
import 'package:instgramclone/screens/test_screen.dart';
import 'package:instgramclone/screens/verifiy_email_screen.dart';
import 'package:instgramclone/services/bloc/auth_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';
import 'package:instgramclone/services/bloc/auth_state.dart';
import 'package:instgramclone/services/bloc/firebase_auth_provider.dart';
import 'package:instgramclone/utilities/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instgram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading &&
            state is! AuthStateRegistering &&
            state is! AuthStateLoggedOut) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait -main-',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        log(state.toString());
        if (state is AuthStateLoggedIn) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
            ],
            child: const ResponsiveScreenLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            ),
          );
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailScreen();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateForgotPassword) {
          return const Scaffold();
        } else if (state is AuthStateRegistering) {
          return const SignupScreen();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
