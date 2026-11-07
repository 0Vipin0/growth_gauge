import 'package:flutter/material.dart';

class const HubHeader({super.key, final VoidCallback? onProfileTap})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.person, color: colorScheme.primary),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Alex Doe',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(12),
          ),
          icon: Badge(
            label: const Text('1'),
            child: Icon(
              Icons.notifications_outlined,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
