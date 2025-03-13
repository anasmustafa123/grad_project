import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';

class PrimaryHeaderPage extends StatelessWidget {
  const PrimaryHeaderPage({super.key, required this.child, this.containerColor = TColors.primary});

  final Widget child;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return CurveEdgeWidget(
      childWidget: Container(
        color: containerColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  width: 400,
                  height: 400,
                  backgroundColor: TColors.textWhite.withValues(alpha: 0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  width: 400,
                  height: 400,
                  backgroundColor: TColors.textWhite.withValues(alpha: 0.1),
                )),
            Column(
              children: [
                AppBar(),
              ],
            ),
            child
          ],
        ),
      ),
    );
  }
}
