import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      action: SnackBarAction(
        label: S.of(context).dismiss,
        onPressed: () {},
      ),
    ),
  );
}
