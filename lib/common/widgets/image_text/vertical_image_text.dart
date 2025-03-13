import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText(
      {super.key,
      required this.img,
      this.insideText = "",
      required this.textColor,
      this.backgroundColor,
      required this.onTap});

  final String img, insideText;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.only(right: TSizes.spaceBtwItems),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  padding: EdgeInsets.all(TSizes.sm),
                  decoration: BoxDecoration(
                      color: backgroundColor ??
                          (isDarkMode ? TColors.light : TColors.dark),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Image(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                      color: isDarkMode ? TColors.dark : TColors.light,
                    ),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                SizedBox(
                  width: 55,
                  child: Text(
                    insideText,
                    style: TextTheme.of(context)
                        .labelMedium!
                        .apply(color: textColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            )));
  }
}
