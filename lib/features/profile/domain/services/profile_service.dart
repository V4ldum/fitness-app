import 'package:fitness_app/features/profile/domain/models/profile.dart';
import 'package:fitness_app/shared/helpers/network.dart';

import '../repository/profile_repository.dart';

class ProfileService implements ProfileRepository {
  @override
  Future<Profile> getProfile() async {
    await Network.emulate();
    return Profile(
      name: "Cat Bumstead",
      imageUrl: "assets/strong_cat.png",
    ); //TODO network query
  }
}
//TODO json version
/*
static Future<Map> profile() async {
    //emulate API call
    return json.decode(await rootBundle.loadString('assets/profile.json'));
  }
*/
