import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:sengthaite_blog/constants/theme.dart';
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
    final config = MaterialTheme.isDark(context)
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;

    return MarkdownWidget(
      data: markdown,
      tocController: tocController,
      config: config.copy(
        configs: [
          PreConfig(
            theme: androidstudioTheme,
            textStyle: GoogleFonts.firaCode(),
            wrapper: (Widget child, String code, String language) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.grey[200],
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
        ],
      ),
    );
  }
}
