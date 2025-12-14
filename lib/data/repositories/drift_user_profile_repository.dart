import 'dart:convert';

import 'package:drift/drift.dart';

import '../../features/profile/model/user_profile.dart';
import '../services/persistence/app_database.dart';
import 'user_profile_repository.dart';

class DriftUserProfileRepository implements UserProfileRepository {
  final AppDatabase db;

  DriftUserProfileRepository(this.db);

  @override
  Future<UserProfile?> loadProfile() async {
    final rows = await (db.select(db.users)).get();
    if (rows.isEmpty) return null;
    final row = rows.first;
    final data = row.dataJson == null ? null : jsonDecode(row.dataJson! as String) as Map<String, dynamic>;
    final assessment = row.assessmentJson == null ? null : jsonDecode(row.assessmentJson! as String) as Map<String, dynamic>;
    return UserProfile(
      id: row.id,
      creationDate: row.creationDate,
      lastAssessmentDate: row.lastAssessmentDate,
      fitnessScore: row.fitnessScore,
      data: data == null ? null : FitnessData.fromJson(data),
      assessment: assessment == null ? null : AssessmentResult.fromJson(assessment),
    );
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    final dataJson = profile.data?.toJson();
    final assessmentJson = profile.assessment?.toJson();

    await db.into(db.users).insertOnConflictUpdate(UsersCompanion(
      id: Value(profile.id),
      creationDate: Value(profile.creationDate),
      lastAssessmentDate: Value(profile.lastAssessmentDate),
      fitnessScore: Value(profile.fitnessScore),
      dataJson: Value(dataJson == null ? null : jsonEncode(dataJson)),
      assessmentJson: Value(assessmentJson == null ? null : jsonEncode(assessmentJson)),
    ));
  }
}
