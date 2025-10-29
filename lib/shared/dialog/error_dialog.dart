import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';

void showErrorDialog({
  required Widget title,
  required Widget content,
  Function()? onDismiss,
}) {
  showDialog(
    context: Navigation().context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(Icons.error),
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              if (onDismiss != null) onDismiss();
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
