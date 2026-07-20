import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class StarRating extends StatefulWidget {
  /// Widget StarRating : enable drag and click to rate the star
  ///
  const StarRating({
    super.key,
    required this.defaultStarRating,
    required this.onRatingChange,
  });

  final int defaultStarRating;
  final ValueCallback<int> onRatingChange;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  final _starKey = GlobalKey();
  int star = 2;

  @override
  void initState() {
    star = widget.defaultStarRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        var starRenderBox =
            _starKey.currentContext?.findRenderObject() as RenderBox?;
        if (starRenderBox == null) return;
        var offset = starRenderBox.localToGlobal(Offset.zero);
        var currentStartX = details.globalPosition.dx - offset.dx;
        var currentStar = ((currentStartX - 56) / 56).toInt();
        widget.onRatingChange(currentStar);
        setState(() {
          star = currentStar;
        });
      },
      onTapDown: (details) {
        var starRenderBox =
            _starKey.currentContext?.findRenderObject() as RenderBox?;
        if (starRenderBox == null) return;
        var offset = starRenderBox.localToGlobal(Offset.zero);
        var currentStartX = details.globalPosition.dx - offset.dx;
        var currentStar = (currentStartX / 56).toInt();
        widget.onRatingChange(currentStar);
        setState(() {
          star = currentStar;
        });
      },
      child: Row(
        key: _starKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Icon(
            index < star ? Icons.star : Icons.star_outline,
            color: index < star
                ? context.pfTheme.starColor
                : context.pfTheme.buttonFgColor,
            size: 56,
          );
        }).toList(),
      ),
    );
  }
}
