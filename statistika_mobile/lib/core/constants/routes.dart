abstract class ApiRoutes {
  static const baseUrl = 'http://10.0.2.2:8080';

  static const register = '$baseUrl/auth/register';
  static const login = '$baseUrl/auth/login';
  static const userInfo = '$baseUrl/user_info';

  static const surveys = '$baseUrl/surveys';

  static const sections = '$baseUrl/sections';

  static const forms = '$baseUrl/forms';

  static const answers = '$baseUrl/answers';

  static const answersForForm = '$answers/form';

  static const questions = '$baseUrl/questions';
}

abstract class NavigationRoutes {
  static const auth = 'auth';

  static const generalQuestions = 'general_questions';

  static const surveys = 'surveys';
  static const forms = 'forms';

  static const welcomeForm = 'welcome_form';
  static const fillForm = 'fill_form';
  static const endForm = 'end_form';

  static const profile = 'profile';
}
