import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';

class CategoryItemIcon extends StatelessWidget {
  const CategoryItemIcon({
    super.key,
    required this.image,
    required this.title,
  });

  final Widget image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          decoration: BoxDecoration(
            color: MaterialTheme.colorScheme(context).surfaceContainer,
            border: Border.all(
              color: MaterialTheme.colorScheme(context).outline,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: image,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Flexible(
          child: SizedBox(
            width: 64,
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        )
      ],
    );
  }
}
