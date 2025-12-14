import 'package:uuid/uuid.dart';

class FitnessData {
  final String? gender;
  final int? age;
  final double? heightCm;
  final double? weightKg;
  final int? restingHeartRate;

  FitnessData(
      {this.gender,
      this.age,
      this.heightCm,
      this.weightKg,
      this.restingHeartRate});

  FitnessData copyWith(
      {String? gender,
      int? age,
      double? heightCm,
      double? weightKg,
      int? restingHeartRate}) {
    return FitnessData(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
    );
  }

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'age': age,
        'height_cm': heightCm,
        'weight_kg': weightKg,
        'resting_heart_rate': restingHeartRate,
      };

  factory FitnessData.fromJson(Map<String, dynamic> json) => FitnessData(
        gender: json['gender'] as String?,
        age: json['age'] as int?,
        heightCm: (json['height_cm'] as num?)?.toDouble(),
        weightKg: (json['weight_kg'] as num?)?.toDouble(),
        restingHeartRate: json['resting_heart_rate'] as int?,
      );
}

class AssessmentResult {
  final double? bmi;
  final int? predictedMaxHeartRate;
  final int? fitnessScore;

  AssessmentResult({this.bmi, this.predictedMaxHeartRate, this.fitnessScore});

  AssessmentResult copyWith(
      {double? bmi, int? predictedMaxHeartRate, int? fitnessScore}) {
    return AssessmentResult(
      bmi: bmi ?? this.bmi,
      predictedMaxHeartRate:
          predictedMaxHeartRate ?? this.predictedMaxHeartRate,
      fitnessScore: fitnessScore ?? this.fitnessScore,
    );
  }

  Map<String, dynamic> toJson() => {
        'bmi': bmi,
        'predicted_max_heart_rate': predictedMaxHeartRate,
        'fitness_score': fitnessScore,
      };

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      AssessmentResult(
        bmi: (json['bmi'] as num?)?.toDouble(),
        predictedMaxHeartRate: json['predicted_max_heart_rate'] as int?,
        fitnessScore: json['fitness_score'] as int?,
      );
}

class UserProfile {
  final String id;
  final DateTime creationDate;
  final DateTime? lastAssessmentDate;
  final int? fitnessScore;
  final FitnessData? data;
  final AssessmentResult? assessment;

  UserProfile(
      {required this.id,
      required this.creationDate,
      this.lastAssessmentDate,
      this.fitnessScore,
      this.data,
      this.assessment});

  factory UserProfile.createEmpty() =>
      UserProfile(id: const Uuid().v4(), creationDate: DateTime.now());

  UserProfile copyWith(
      {String? id,
      DateTime? creationDate,
      DateTime? lastAssessmentDate,
      int? fitnessScore,
      FitnessData? data,
      AssessmentResult? assessment}) {
    return UserProfile(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      lastAssessmentDate: lastAssessmentDate ?? this.lastAssessmentDate,
      fitnessScore: fitnessScore ?? this.fitnessScore,
      data: data ?? this.data,
      assessment: assessment ?? this.assessment,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'creation_date': creationDate.toIso8601String(),
        'last_assessment_date': lastAssessmentDate?.toIso8601String(),
        'fitness_score': fitnessScore,
        'data': data?.toJson(),
        'assessment': assessment?.toJson(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        creationDate: DateTime.parse(json['creation_date'] as String),
        lastAssessmentDate: json['last_assessment_date'] == null
            ? null
            : DateTime.parse(json['last_assessment_date'] as String),
        fitnessScore: json['fitness_score'] as int?,
        data: json['data'] == null
            ? null
            : FitnessData.fromJson(
                Map<String, dynamic>.from(json['data'] as Map)),
        assessment: json['assessment'] == null
            ? null
            : AssessmentResult.fromJson(
                Map<String, dynamic>.from(json['assessment'] as Map)),
      );
}
