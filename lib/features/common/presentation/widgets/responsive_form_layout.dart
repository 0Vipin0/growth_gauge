import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class const ResponsiveFormLayout({super.key, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kTabletScreenSize) {
          return Center(child: SizedBox(width: 600, child: child));
        } else {
          return child;
        }
      },
    );
  }
}
