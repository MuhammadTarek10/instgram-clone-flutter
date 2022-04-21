import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgramclone/services/bloc/auth_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifiy Email Address')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Text(
                "We've sent you an email, please check it to verifiy",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                ),
              ),
              flex: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              child: const Text(
                "Havn't recieved an email? Click here to send again",
              ),
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              child: const Text(
                "Go to Login Page",
              ),
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
