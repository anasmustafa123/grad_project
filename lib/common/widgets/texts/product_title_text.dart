import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    this.smallSize = false,
    required this.title,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final bool smallSize;
  final String title;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize ? TextTheme.of(context).labelLarge : TextTheme.of(context).titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
