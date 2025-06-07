import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 904;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 904 &&
      MediaQuery.of(context).size.width < 1280;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width < 904) {
      // Mobile layout
      return mobile;
    } else if (size.width >= 904 && size.width < 1280) {
      // Tablet layout
      return tablet;
    } else {
      // Desktop layout
      return desktop;
    }
  }
}
