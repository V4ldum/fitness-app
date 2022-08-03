import 'package:fitness_app/features/app_wide/domain/models/api_response.dart';

abstract class LoginRepository {
  const LoginRepository();

  Future<APIResponse<Map<String, Object>>> login(
      String username, String password);
  Future<bool> openForgottenPasswordPage();
  Future<bool> openRegistrationPage();
}
