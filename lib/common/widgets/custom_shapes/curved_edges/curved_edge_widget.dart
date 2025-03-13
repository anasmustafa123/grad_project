import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class CurveEdgeWidget extends StatelessWidget {
  const CurveEdgeWidget({super.key, this.childWidget});
  final Widget? childWidget;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: childWidget);
  }
}