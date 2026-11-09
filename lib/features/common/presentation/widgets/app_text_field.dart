import 'package:flutter/material.dart';

class const AppTextField({
  super.key,
  final TextEditingController? controller,
  required final String label,
  final String? hintText,
  final IconData? prefixIcon,
  final String? suffixUnit,
  final String? helperText,
  final String? errorText,
  final bool obscureText = false,
  final TextInputType? keyboardType,
  final ValueChanged<String>? onChanged,
  final int? maxLength,
  final int maxLines = 1,
  final bool readOnly = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        // Standardized dark fill (surfaceContainerLow) with 12dp border radius
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        suffixText: suffixUnit,
        suffixStyle: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
