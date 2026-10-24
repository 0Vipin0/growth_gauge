import 'package:flutter/material.dart';

/// Window classes are based on available logical width, not device identity.
enum AppWindowSizeClass(final double maxWidth) {
  compact(600),
  medium(1024),
  expanded(double.infinity);

  static AppWindowSizeClass fromWidth(double width) {
    if (width <= compact.maxWidth) return compact;
    if (width <= medium.maxWidth) return medium;
    return expanded;
  }
}

/// Keeps long-form content readable on wide windows while using narrow space
/// fully on phones and compact windows.
class const ResponsiveContent({
  super.key,
  required final Widget child,
  final double maxWidth = 1200,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
