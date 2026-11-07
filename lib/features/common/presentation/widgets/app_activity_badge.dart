import 'package:flutter/material.dart';

enum ActivityType() {
  warmUp,
  interval,
  reps,
  rest,
  coolDown,
}

extension ActivityTypeExtension on ActivityType {
  String get label {
    switch (this) {
      case ActivityType.warmUp:
        return 'Warm Up';
      case ActivityType.interval:
        return 'Interval';
      case ActivityType.reps:
        return 'Reps';
      case ActivityType.rest:
        return 'Rest';
      case ActivityType.coolDown:
        return 'Cool Down';
    }
  }

  IconData get icon {
    switch (this) {
      case ActivityType.warmUp:
        return Icons.directions_run; // Runner icon[cite: 1]
      case ActivityType.interval:
        return Icons.timer; // Stopwatch icon[cite: 1]
      case ActivityType.reps:
        return Icons.fitness_center; // Dumbbell icon[cite: 1]
      case ActivityType.rest:
        return Icons.bedtime; // Zzz clock icon[cite: 1]
      case ActivityType.coolDown:
        return Icons.ac_unit; // Snowflake icon[cite: 1]
    }
  }

  Color get themeColor {
    switch (this) {
      case ActivityType.warmUp:
        return const Color(0xFFFFB300); // Amber[cite: 1]
      case ActivityType.interval:
        return const Color(0xFF9FA8DA); // Purple / Indigo tint[cite: 1]
      case ActivityType.reps:
        return const Color(0xFF00FF66); // Forest Green[cite: 1]
      case ActivityType.rest:
        return const Color(0xFF78909C); // Grey-Blue[cite: 1]
      case ActivityType.coolDown:
        return const Color(0xFF00E5FF); // Cyan[cite: 1]
    }
  }
}

enum AppActivityBadgeVariant() {
  circularIcon,
  textPill,
}

class AppActivityBadge extends StatelessWidget {
  final ActivityType activityType;
  final AppActivityBadgeVariant variant;

  const new({
    super.key,
    required this.activityType,
    this.variant = AppActivityBadgeVariant.circularIcon,
  });

  const new pill({super.key, required this.activityType})
    : variant = AppActivityBadgeVariant.textPill;

  @override
  Widget build(BuildContext context) {
    final color = activityType.themeColor;

    if (variant == AppActivityBadgeVariant.textPill) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          activityType.label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: color,
          ),
        ),
      );
    }

    // Circular Container Icon Badge
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(activityType.icon, size: 22, color: color)),
    );
  }
}
