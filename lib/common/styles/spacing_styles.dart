import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class TSpacingStyles {
  TSpacingStyles._(); // private constructor

  static const EdgeInsetsGeometry paddingWithBarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      bottom: TSizes.defaultSpace,
      right: TSizes.defaultSpace,
      left: TSizes.defaultSpace);
}
