import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class ScrollRoundedImage extends StatelessWidget {
  const ScrollRoundedImage({
    super.key,
    this.backgroundColor,
    this.height,
    this.width,
    this.padding,
    required this.imgUrl,
    this.applyBorderRadius = true,
    this.border,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imgUrl;
  final bool applyBorderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(border: border, color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
          child: ClipRRect(
            borderRadius: applyBorderRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
            child: Image(image: isNetworkImage ? NetworkImage(imgUrl) : AssetImage(imgUrl), fit: fit),
          )),
    );
  }
}
