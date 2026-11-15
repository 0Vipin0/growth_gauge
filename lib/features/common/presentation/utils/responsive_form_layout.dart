import 'package:flutter/material.dart';

import 'responsive_layout.dart';

class const ResponsiveFormLayout({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveContent(maxWidth: 600, child: child);
  }
}
