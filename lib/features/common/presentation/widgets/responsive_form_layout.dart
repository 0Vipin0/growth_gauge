import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';

class ResponsiveFormLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveFormLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kTabletScreenSize) {
          return Center(
            child: SizedBox(
              width: 600,
              child: child,
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
