import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class CategoryItemIcon extends StatelessWidget {
  const CategoryItemIcon({super.key, required this.image, required this.title});

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
            color: context.colorScheme.onSecondary,
            border: Border.all(color: context.colorScheme.outline, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .2),
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: const Offset(1, 5),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: image,
        ),
        const SizedBox(height: 4),
        Flexible(
          child: SizedBox(
            width: 64,
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
