abstract class LoginRepository {
  const LoginRepository();

  Future<bool> login(String username, String password);
  Future<bool> openForgottenPasswordPage();
  Future<bool> openRegistrationPage();
}
