import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/device/device_utility.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return Material(
        color: isDarkMode ? TColors.black : TColors.white,
        child: TabBar(
          isScrollable: true,
          indicatorColor: TColors.primary,
          labelColor: isDarkMode ? TColors.white : TColors.primary,
          tabs: tabs,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
