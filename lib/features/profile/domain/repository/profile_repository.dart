import '../models/profile.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  Future<Profile> getProfile();
}
