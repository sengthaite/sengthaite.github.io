import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  final Icon? icon;
  final String text;
  final VoidCallback onPressed;

  const ButtonView({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Row(
        children: [
          ?icon,
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
