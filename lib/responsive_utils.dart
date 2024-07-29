import 'dart:ui';

import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return screenWidth(context) >= 600 && screenWidth(context) < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 1200;
  }

  static double responsiveValue(
      BuildContext context, double small, double medium, double large) {
    if (isSmallScreen(context)) {
      return small;
    } else if (isMediumScreen(context)) {
      return medium;
    } else {
      return large;
    }
  }
}

// Define some responsive padding
class ResponsivePadding extends StatelessWidget {
  final Widget child;

  ResponsivePadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.all(ResponsiveUtils.responsiveValue(context, 8, 16, 24)),
      child: child,
    );
  }
}

// Define some responsive text style
TextStyle responsiveTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveUtils.responsiveValue(context, 14, 18, 22),
  );
}
