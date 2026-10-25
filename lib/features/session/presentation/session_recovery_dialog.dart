import 'package:flutter/material.dart';

import '../domain/workout_session.dart';

Future<WorkoutSession?> showSessionRecoveryDialog(
  BuildContext context,
  List<WorkoutSession> sessions,
) => showDialog<WorkoutSession>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Unfinished workout'),
    content: SizedBox(
      width: 420,
      child: ListView(
        shrinkWrap: true,
        children: [
          for (final session in sessions)
            ListTile(
              leading: const Icon(Icons.replay),
              title: Text(session.templateName),
              subtitle: Text(session.status.name.toUpperCase()),
              onTap: () => Navigator.pop(context, session),
            ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Later'),
      ),
    ],
  ),
);
