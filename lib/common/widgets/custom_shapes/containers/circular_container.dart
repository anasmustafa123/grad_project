import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer(
      {super.key,
      this.width,
      this.height,
      this.padding,
      this.backgroundColor = TColors.white,
      this.child,
      this.margin,
      this.radius = TSizes.cardRadiusLg,
      this.showBorder = false,
      this.borderColor = TColors.borderPrimary});

  final double? width, height;
  final EdgeInsetsGeometry? padding, margin;
  final Color backgroundColor;
  final Widget? child;
  final double radius;
  final bool showBorder;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          color: backgroundColor,
        ),
        child: child);
  }
}
