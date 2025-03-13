import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = "\$",
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(currencySign + price,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: isLarge
            ? TextTheme.of(context).headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
            : TextTheme.of(context).titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null));
  }
}
