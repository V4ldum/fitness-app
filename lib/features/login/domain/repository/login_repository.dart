import 'package:fitness_app/features/app_wide/domain/models/api_response.dart';

import '../../../app_wide/domain/models/user.dart';

abstract class LoginRepository {
  const LoginRepository();

  Future<APIResponse<User>> login(String username, String password);
  Future<bool> openForgottenPasswordPage();
  Future<bool> openRegistrationPage();
}
