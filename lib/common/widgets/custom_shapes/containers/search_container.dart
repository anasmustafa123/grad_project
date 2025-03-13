import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/device/device_utility.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer(
      {super.key,
      this.text = "Search",
      this.textColor = TColors.darkerGrey,
      this.showBackground = true,
      this.showBorder = true,
      this.onTap,
      this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)});

  final String text;
  final Color textColor;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? isDarkMode
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: Border.all(color: showBorder ? TColors.grey : Colors.transparent),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal,
                color: textColor,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                text,
                style: TextTheme.of(context).bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
