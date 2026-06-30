import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';

class RoleTitleDescriptionVew extends StatelessWidget {
  /// Widget RoleTitleDescriptionView : show the role title and description which contain of working date range and organization
  ///
  const RoleTitleDescriptionVew({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.roleTitle, style: context.pfTheme.roleTitleTextStyle),
          Text(data.description, style: context.pfTheme.roleDetailTextStyle),
        ],
      ),
    );
  }
}
