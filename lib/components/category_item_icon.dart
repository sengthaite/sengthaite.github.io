import 'package:flutter/material.dart';

class CategoryItemIcon extends StatelessWidget {
  const CategoryItemIcon({
    super.key,
    required this.image,
    required this.title,
  });

  final Image image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withAlpha(50),
              width: 0.1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: image,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
