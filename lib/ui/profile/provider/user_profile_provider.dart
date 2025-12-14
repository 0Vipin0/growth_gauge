import 'package:flutter/foundation.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/user_profile_repository.dart';

class UserProfileProvider with ChangeNotifier {
  final UserProfileRepository? repository;

  UserProfileProvider({this.repository});

  UserProfile? _currentUserProfile;
  bool _isLoading = false;

  UserProfile? get currentUserProfile => _currentUserProfile;
  bool get isLoading => _isLoading;

  Future<void> loadInitialProfile() async {
    _isLoading = true;
    notifyListeners();

    if (repository != null) {
      _currentUserProfile =
          await repository!.loadProfile() ?? UserProfile.createEmpty();
    } else {
      // Fallback: initialize with an empty profile.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      _currentUserProfile = UserProfile.createEmpty();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveProfile() async {
    if (_currentUserProfile == null || repository == null) return;
    await repository!.saveProfile(_currentUserProfile!);
  }

  void updateBiometrics(
      {int? age, double? heightCm, double? weightKg, int? restingHr}) {
    final data = _currentUserProfile?.data ?? FitnessData();
    final updated = data.copyWith(
      age: age ?? data.age,
      heightCm: heightCm ?? data.heightCm,
      weightKg: weightKg ?? data.weightKg,
      restingHeartRate: restingHr ?? data.restingHeartRate,
    );

    _currentUserProfile = _currentUserProfile?.copyWith(data: updated) ??
        UserProfile(
          id: const Uuid().v4(),
          creationDate: DateTime.now(),
          data: updated,
        );

    notifyListeners();
  }

  void setProfile(UserProfile profile) {
    _currentUserProfile = profile;
    notifyListeners();
  }
}
