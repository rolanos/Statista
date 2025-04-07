abstract class ApiRoutes {
  static const baseUrl = 'http://10.0.2.2:8080';

  static const register = '$baseUrl/auth/register';
  static const login = '$baseUrl/auth/login';

  static const surveys = '$baseUrl/surveys';

  static const sections = '$baseUrl/sections';

  static const forms = '$baseUrl/forms';

  static const questions = '$baseUrl/questions';
}
