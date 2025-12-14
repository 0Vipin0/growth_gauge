import 'package:growth_gauge/data/models/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile?> loadProfile();
  Future<void> saveProfile(UserProfile profile);
}
