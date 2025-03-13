import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.select,
    this.onSelect,
    required this.isCircular,
  });

  final String text;
  final bool select, isCircular;
  final void Function(bool)? onSelect;

  @override
  Widget build(BuildContext context) {
    final color = THelperFunctions.getColor(text);
    return Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: ChoiceChip(
          label: !isCircular
              ? Text(text)
              : color == null
                  ? SizedBox()
                  : Text(''),
          selected: select,
          onSelected: (value) {},
          labelStyle: TextStyle(color: select ? TColors.white : null),
          avatar: isCircular ? CircularContainer(backgroundColor: color ?? TColors.primary) : null,
          shape: isCircular ? CircleBorder() : null,
          labelPadding: isCircular ? EdgeInsets.all(0) : null,
          padding: isCircular ? EdgeInsets.all(0) : null,
          backgroundColor: color,
          selectedColor: color,
        ));
  }
}
