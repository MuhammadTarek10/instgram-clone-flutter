import 'package:flutter/material.dart';
import 'package:instgramclone/utilities/dialogs/generic_dialog.dart';


Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'Restart you password',
    optionsBuilder:() => {
      'Ok': null
    },
  );
}
