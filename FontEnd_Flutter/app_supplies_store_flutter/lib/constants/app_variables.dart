import 'package:flutter/material.dart';

double appIndent(BuildContext context, {double factor = 0.02}) {
  final screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * factor;
}
