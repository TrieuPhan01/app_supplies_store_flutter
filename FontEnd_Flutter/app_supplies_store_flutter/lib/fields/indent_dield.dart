import 'package:app_supplies_store_flutter/constants/app_variables.dart';
import 'package:flutter/material.dart';

class IndentField extends StatelessWidget {
  static const double INDENT_FACTOR = 1.5;
  static double indentSpacing = 10.0;
  // static double indentSpacing() => _context != null ? appIndent(_context!) * INDENT_FACTOR : 10.0 * INDENT_FACTOR;
  // static BuildContext? _context;

  final Widget? child;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  const IndentField({
    Key? key,
    this.child,
    this.alignment,
    this.width = double.infinity,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: this.width,
    height: this.height,
    alignment: this.alignment,
    padding: EdgeInsets.symmetric(horizontal: appIndent(context) * INDENT_FACTOR),
    child: this.child,
  );
}
