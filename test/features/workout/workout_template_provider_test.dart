import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/workout/model/workout_template.dart';
import 'package:growth_gauge/features/workout/provider/workout_template_provider.dart';

void main() {
  test('WorkoutTemplateProvider add and delete', () async {
    final provider = WorkoutTemplateProvider();
    expect(provider.templates.length, 0);

    final t = WorkoutTemplate(name: 'Morning Routine');
    await provider.addTemplate(t);
    expect(provider.templates.length, 1);

    await provider.deleteTemplate(t.id);
    expect(provider.templates.length, 0);
  });
}
