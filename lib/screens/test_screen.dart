import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgramclone/services/bloc/auth_bloc.dart';
import 'package:instgramclone/services/bloc/auth_event.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logged In')),
      body: Center(
        child: TextButton(
          child: const Text('Back'),
          onPressed: () => context.read<AuthBloc>().add(
                const AuthEventLogOut(),
              ),
        ),
      ),
    );
  }
}
