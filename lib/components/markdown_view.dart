import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.markdown,
    this.textScaleFactor = 1,
  });

  final String markdown;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return MarkdownBody(
      data: markdown,
      // selectable: true,
      softLineBreak: true,
      onTapLink: (text, link, _) {
        final url = link ?? '/';
        if (url.startsWith('http')) {
          launchUrl(Uri.parse(url));
        } else {}
      },
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
      ),
      styleSheet: MarkdownStyleSheet(
        textScaler: TextScaler.linear(textScaleFactor),
        p: textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: colors.onSurface.withOpacity(0.72),
        ),
        a: TextStyle(
          decoration: TextDecoration.underline,
          color: colors.onSurface.withOpacity(0.72),
        ),
        h1: textTheme.displaySmall!.copyWith(
          fontSize: 25,
          color: colors.onSurface,
        ),
        h2: textTheme.headlineLarge!.copyWith(
          fontSize: 20,
          color: colors.onSurface,
        ),
        h3: textTheme.headlineMedium!.copyWith(
          fontSize: 18,
          color: colors.onSurface,
        ),
        h4: textTheme.headlineSmall!.copyWith(
          fontSize: 16,
          color: colors.onSurface,
        ),
        h5: textTheme.titleLarge!.copyWith(
          fontSize: 16,
          color: colors.onSurface,
        ),
        h6: textTheme.titleMedium!.copyWith(
          fontSize: 16,
          color: colors.onSurface,
        ),
        listBullet: textTheme.bodyLarge!.copyWith(
          color: colors.onSurface,
        ),
        em: const TextStyle(fontStyle: FontStyle.italic),
        strong: const TextStyle(fontWeight: FontWeight.bold),
        blockquote: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: colors.onSurfaceVariant,
        ),
        blockquoteDecoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(4),
        ),
        code: const TextStyle(fontFamily: 'monospace'),
        tableHead: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        tableBody: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        blockSpacing: 8,
        listIndent: 32,
        blockquotePadding: const EdgeInsets.all(8),
        h1Padding: const EdgeInsets.symmetric(vertical: 8),
        h2Padding: const EdgeInsets.symmetric(vertical: 8),
        h3Padding: const EdgeInsets.symmetric(vertical: 8),
        h4Padding: const EdgeInsets.symmetric(vertical: 8),
        h5Padding: const EdgeInsets.symmetric(vertical: 8),
        h6Padding: const EdgeInsets.symmetric(vertical: 8),
        codeblockPadding: const EdgeInsets.all(8),
        // codeblockDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(4),
        //   color: colors.surfaceVariant,
        // ),
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colors.outline.withOpacity(0.4),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
