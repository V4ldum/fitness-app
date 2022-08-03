import '../domain.dart';

abstract class AppWideRepository {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> updateTokens(String accessToken, String refreshToken);
  Future<void> deleteTokens();
  Future<APIResponse<User>> authenticate(String accessToken);
  Future<APIResponse<Map<String, String>>> refresh(String refreshToken);
}
