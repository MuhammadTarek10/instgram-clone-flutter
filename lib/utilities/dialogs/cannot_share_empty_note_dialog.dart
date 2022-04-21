import 'package:flutter/material.dart';
import 'package:instgramclone/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You can share',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
