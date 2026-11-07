import 'package:flutter/material.dart';

enum AppButtonVariant() {
  primary,
  secondary,
  outlined,
  ghost,
  destructive,
  transport,
}

class AppButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final String? tooltip;

  const new({
    super.key,
    this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.tooltip,
  });

  const new primary({
    super.key,
    required String this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.tooltip,
  }) : variant = AppButtonVariant.primary;

  const new secondary({
    super.key,
    required String this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.tooltip,
  }) : variant = AppButtonVariant.secondary;

  const new outlined({
    super.key,
    required String this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.tooltip,
  }) : variant = AppButtonVariant.outlined;

  const new ghost({
    super.key,
    required String this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.tooltip,
  }) : variant = AppButtonVariant.ghost;

  const new destructive({
    super.key,
    required String this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.tooltip,
  }) : variant = AppButtonVariant.destructive;

  const new transport({
    super.key,
    required IconData this.icon,
    required this.onPressed,
    this.tooltip,
    this.isLoading = false,
  }) : variant = AppButtonVariant.transport,
       label = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    if (variant == AppButtonVariant.transport) {
      return Tooltip(
        message: tooltip ?? '',
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
          child: Material(
            color: colorScheme.primaryContainer,
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: isLoading ? null : onPressed,
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      )
                    : Icon(
                        icon,
                        color: colorScheme.onPrimaryContainer,
                        size: 28,
                      ),
              ),
            ),
          ),
        ),
      );
    }

    final Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == AppButtonVariant.primary
                  ? const Color(0xFF003913)
                  : colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        if (label != null)
          Text(
            label!,
            style: textTheme.labelLarge?.copyWith(
              color: variant == AppButtonVariant.primary
                  ? const Color(0xFF003913)
                  : null,
            ),
          ),
      ],
    );

    // Enforce minimum 48x48 dp touch target per A11y spec
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      child: _buildButtonWidget(colorScheme, child),
    );
  }

  Widget _buildButtonWidget(ColorScheme colorScheme, Widget child) {
    switch (variant) {
      case AppButtonVariant.primary:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: const Color(0xFF003913),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.secondary:
        return FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.outline, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.ghost:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.destructive:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.errorContainer,
            foregroundColor: colorScheme.onErrorContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.transport:
        return const SizedBox.shrink();
    }
  }
}
