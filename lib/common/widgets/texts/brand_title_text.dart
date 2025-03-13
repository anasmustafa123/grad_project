import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/enums.dart';
import '../../../utils/constants/colors.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key,
    required this.title,
    this.color = TColors.primary,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final TextAlign? textAlign;
  final int maxLines;
  final TextSizes brandTextSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: brandTextSize == TextSizes.small
          ? TextTheme.of(context).labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
              ? TextTheme.of(context).bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.large
                  ? TextTheme.of(context).titleLarge!.apply(color: color)
                  : TextTheme.of(context).bodyMedium!.apply(color: color),
    );
  }
}
