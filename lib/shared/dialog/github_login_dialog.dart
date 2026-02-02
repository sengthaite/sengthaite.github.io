import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/shared/common/checkbox_text.dart';

void showGithubLoginDialog({Function()? onDismiss}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Navigation().context,
    builder: (context) {
      return AlertDialog(
        icon: AssetIcons.github.image,
        title: Text("Github Login"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(decoration: InputDecoration(hintText: "Username")),
              TextFormField(decoration: InputDecoration(hintText: "Token")),
              SizedBox(height: 8),
              CheckboxText(text: "Remember me"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (onDismiss != null) onDismiss();
              Navigator.pop(context, 'OK');
            },
            child: TextButton(onPressed: () {}, child: Text("Authenticate")),
          ),
        ],
      );
    },
  );
}
