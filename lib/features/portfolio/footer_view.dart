import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Published in 2026",
        style: textStyle.copyWith(color: textColor.withAlpha(200)),
      ),
    );
  }
}
