import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/constants/svg_images.dart';
import 'package:instgramclone/exceptions/auth_exceptions.dart';
import 'package:instgramclone/services/bloc/auth_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';
import 'package:instgramclone/services/bloc/auth_state.dart';
import 'package:instgramclone/utilities/colors.dart';
import 'package:instgramclone/utilities/dialogs/error_dialog.dart';
import 'package:instgramclone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _bioController;
  late final TextEditingController _usernameController;
  Uint8List? _tempImage;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _bioController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  selectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final tempImage = await image!.readAsBytes();
    setState(() {
      _tempImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) async {
      if (state is AuthStateRegistering) {
        if (state.exception is WeakPasswordAuthException) {
          await showErrorDialog(
            context,
            'Weak Password',
          );
        } else if (state.exception is EmailAlreadyExistedException) {
          await showErrorDialog(
            context,
            'Email Already Registered',
          );
        } else if (state.exception is InvalidEmailAuthException) {
          await showErrorDialog(
            context,
            'Invalid Email',
          );
        } else if (state is GenericAuthException) {
          await showErrorDialog(
            context,
            'Authentication Error',
          );
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                Stack(
                  children: [
                    _tempImage != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_tempImage!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://icon-library.com/images/unknown-person-icon/unknown-person-icon-4.jpg',
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 4,
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
                  textInputType: TextInputType.emailAddress,
                  isPass: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final username = _usernameController.text;
                    final bio = _bioController.text;
                    context.read<AuthBloc>().add(AuthEventRegister(
                          email,
                          password,
                          username,
                          bio,
                          _tempImage,
                        ));
                  },
                  child: Container(
                    child: (state.isLoading)
                        ? const CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : const Text('Sign up'),
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
                        context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                      },
                      child: Container(
                        child: const Text(
                          "Already have an account? ",
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(const AuthEventLogOut());
                      },
                      child: Container(
                        child: const Text(
                          "Login here!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
