import 'package:flutter/material.dart';
import 'package:instgramclone/providers/user_provider.dart';
import 'package:instgramclone/utilities/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveScreenLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveScreenLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveScreenLayout> createState() => _ResponsiveScreenLayoutState();
}

class _ResponsiveScreenLayoutState extends State<ResponsiveScreenLayout> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > weScreenSize) {
          return widget.webScreenLayout;
        } else {
          return widget.mobileScreenLayout;
        }
      },
    );
  }
}
