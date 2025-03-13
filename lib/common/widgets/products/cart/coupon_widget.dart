import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return CircularContainer(
      showBorder: true,
      backgroundColor: isDarkMode ? TColors.dark : TColors.white,
      padding: EdgeInsets.only(top: TSizes.sm, right: TSizes.sm, bottom: TSizes.sm, left: TSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter Here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: isDarkMode ? TColors.white.withValues(alpha: 0.5) : TColors.dark.withValues(alpha: 0.5),
                  backgroundColor: TColors.grey.withValues(alpha: 0.2),
                  side: BorderSide(color: TColors.grey.withValues(alpha: 0.1)),
                ),
                child: Text('Apply'),
              )),
        ],
      ),
    );
  }
}
