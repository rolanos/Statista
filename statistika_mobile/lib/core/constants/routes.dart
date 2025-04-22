abstract class ApiRoutes {
  static const baseUrl = 'http://10.0.2.2:8080';

  static const register = '$baseUrl/auth/register';
  static const login = '$baseUrl/auth/login';
  static const userInfo = '$baseUrl/user_info';

  static const surveys = '$baseUrl/surveys';

  static const sections = '$baseUrl/sections';

  static const forms = '$baseUrl/forms';

  static const formsByFormId = '$forms/formId';

  static const answers = '$baseUrl/answers';

  static const availableAnswer = '$baseUrl/avaliable_answer';

  static const answersForForm = '$answers/form';

  static const questions = '$baseUrl/questions';

  static const generalQuestion = '$questions/general';

  static const analitical = '$baseUrl/analitical';
}

abstract class NavigationRoutes {
  static const auth = 'auth';

  static const generalQuestions = 'general_questions';
  static const createGeneralQuestion = 'create_general_question';

  static const surveys = 'surveys';
  static const forms = 'forms';
  static const createForm = 'create_form';
  static const formEditer = 'form_editer_screen';
  static const formAnalitic = 'form_analitic';

  static const welcomeForm = 'welcome_form';
  static const fillForm = 'fill_form';
  static const endForm = 'end_form';

  static const profile = 'profile';
}
