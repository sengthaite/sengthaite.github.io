import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';

import 'package:url_launcher/url_launcher.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.markdown,
    required this.tocController,
    this.textScaleFactor = 1,
  });

  final String markdown;
  final double textScaleFactor;
  final TocController? tocController;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final config = isDarkMode
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;
    var colorScheme = Theme.of(context).colorScheme;

    return MarkdownWidget(
      data: markdown,
      tocController: tocController,
      config: config.copy(
        configs: [
          PreConfig(
            textStyle: GoogleFonts.firaCode(),
            theme: vsTheme,
            decoration: BoxDecoration(color: colorScheme.surfaceContainer),
            wrapper: (Widget child, String code, String language) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: child,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      iconSize: 12,
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Copied to clipboard!")),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          LinkConfig(
            onTap: (link) {
              final url = link;
              if (url.startsWith('http')) {
                launchUrl(Uri.parse(url));
              }
            },
          ),
          CodeConfig(style: GoogleFonts.firaCode()),
        ],
      ),
    );
  }
}
