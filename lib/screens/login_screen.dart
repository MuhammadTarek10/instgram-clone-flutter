import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instgramclone/constants/svg_images.dart';
import 'package:instgramclone/exceptions/auth_exceptions.dart';
import 'package:instgramclone/services/bloc/auth_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';
import 'package:instgramclone/services/bloc/auth_state.dart';
import 'package:instgramclone/utilities/colors.dart';
import 'package:instgramclone/utilities/dialogs/error_dialog.dart';
import 'package:instgramclone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundException) {
            await showErrorDialog(context, 'Cannot find user');
          } else if (state.exception is WrongPasswordAuthException ||
              state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Wrong Credintials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  instgramIcon,
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    context.read<AuthBloc>().add(
                          AuthEventLogIn(
                            _emailController.text,
                            _passwordController.text,
                          ),
                        );
                  },
                  child: Container(
                    child: const Text('Login'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister());
                      },
                      child: Container(
                        child: const Text(
                          "Don't have an account? ",
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister());
                      },
                      child: Container(
                        child: const Text(
                          "Sign up here!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegister());
                  },
                  child: Container(
                    child: const Text(
                      "Forgot your password? Click here!",
                      style: TextStyle(),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
