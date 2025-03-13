import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, this.buttonText = 'view', required this.titleText, this.showButton = false, this.textColor, this.onClickCallback});

  final String titleText, buttonText;
  final bool showButton;
  final Color? textColor;
  final VoidCallback? onClickCallback;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText,
          style: TextTheme.of(context).headlineSmall!.apply(
                color: textColor ?? (isDarkMode ? Colors.white : TColors.black),
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showButton)
          TextButton(
              onPressed: onClickCallback,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor ?? (isDarkMode ? Colors.white : TColors.black),
                ),
              ))
      ],
    );
  }
}
