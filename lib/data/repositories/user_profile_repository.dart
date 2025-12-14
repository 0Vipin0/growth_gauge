import '../../features/profile/model/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile?> loadProfile();
  Future<void> saveProfile(UserProfile profile);
}
