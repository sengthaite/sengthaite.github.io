import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';

// Todo: Update each page to display some activities and what have you do or learn
class EducationView extends StatefulWidget {
  /// Widget EducationView : show all the certificates, archivements in page view
  ///
  const EducationView({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  final int currentPage;
  final ValueCallback<int> onPageChanged;

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  int currentPage = 0;
  late PageController controller;

  @override
  void initState() {
    currentPage = widget.currentPage;
    controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.95,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ContentPage(
              data: context.educationData,
              controller: controller,
              onPageChanged: (index) {
                widget.onPageChanged.call(index);
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
