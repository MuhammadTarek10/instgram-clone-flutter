import 'package:flutter/material.dart';
import 'package:instgramclone/utilities/dialogs/generic_dialog.dart';


Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
      context: context,
      title: 'Something bad happened',
      content: text,
      optionsBuilder: () => {
            'Ok': null,
          });
}
