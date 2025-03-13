import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/features/shop/screens/cart/cart.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({super.key, this.iconColor, this.iconBackgroundColor = TColors.black, this.iconCallbackFn});

  final VoidCallback? iconCallbackFn;
  final Color? iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor ?? (isDarkMode ? TColors.light : TColors.dark),
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(color: iconBackgroundColor, borderRadius: BorderRadius.circular(100)),
              child: Center(
                  child: Text(
                '0',
                style: TextTheme.of(context).labelLarge!.apply(color: TColors.white),
              )),
            )),
      ],
    );
  }
}
