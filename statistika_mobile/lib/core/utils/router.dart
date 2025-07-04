import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/view/authorization_screen.dart';
import 'package:statistika_mobile/features/authorization/view/profile_screen.dart';
import 'package:statistika_mobile/features/form/view/create_form/create_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/end_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/fill_form_screen.dart';
import 'package:statistika_mobile/features/form/view/form_analitic/form_analitic_screen.dart';
import 'package:statistika_mobile/features/form/view/form_editer/form_editer_screen.dart';
import 'package:statistika_mobile/features/form/view/forms/forms_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/welcome_form_screen.dart';
import 'package:statistika_mobile/features/general_question/view/choose_question_type_screen.dart';
import 'package:statistika_mobile/features/general_question/view/create_question_screen.dart';
import 'package:statistika_mobile/features/general_question/view/general_question_screen.dart';
import 'package:statistika_mobile/features/home/home_screen.dart';
import 'package:statistika_mobile/features/survey/view/admin_group/admin_group_screen.dart';

import '../../features/authorization/view/register_screen.dart';
import '../../features/authorization/view/welcome_screen.dart';
import '../../features/survey/view/configuration/survey_configuration_screen.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: '/${NavigationRoutes.welcome}',
    routes: [
      GoRoute(
        path: '/${NavigationRoutes.welcome}',
        name: NavigationRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: NavigationRoutes.auth,
            name: NavigationRoutes.auth,
            builder: (context, state) => const AuthorizationScreen(),
            routes: [
              GoRoute(
                path: NavigationRoutes.register,
                name: NavigationRoutes.register,
                builder: (context, state) => const RegisterScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${NavigationRoutes.generalQuestions}',
                name: NavigationRoutes.generalQuestions,
                builder: (context, state) => const GeneralQuestionScreen(),
                routes: [
                  GoRoute(
                    path: NavigationRoutes.chooseQuestionType,
                    name: NavigationRoutes.chooseQuestionType,
                    builder: (context, state) =>
                        const ChooseQuestionTypeScreen(),
                    redirect: (context, state) async {
                      return await redirectToAuthorization();
                    },
                    routes: [
                      GoRoute(
                        path: NavigationRoutes.createGeneralQuestion,
                        name: NavigationRoutes.createGeneralQuestion,
                        builder: (context, state) => CreateQuestionScreen(
                          type: state.uri.queryParameters['type'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                redirect: (context, state) async {
                  return await redirectToAuthorization();
                },
                path: '/${NavigationRoutes.forms}',
                name: NavigationRoutes.forms,
                builder: (context, state) => const FormsScreen(),
                routes: [
                  GoRoute(
                    path: NavigationRoutes.surveyConfiguration,
                    name: NavigationRoutes.surveyConfiguration,
                    builder: (context, state) => SurveyConfigurationScreen(
                      surveyId: state.uri.queryParameters['surveyId'],
                    ),
                    routes: [
                      GoRoute(
                        path: NavigationRoutes.surveyAdminGroup,
                        name: NavigationRoutes.surveyAdminGroup,
                        builder: (context, state) => AdminGroupScreen(
                          surveyId: state.uri.queryParameters['surveyId'],
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: NavigationRoutes.formAnalitic,
                    name: NavigationRoutes.formAnalitic,
                    builder: (context, state) => FormAnaliticScreen(
                      formId: state.uri.queryParameters['formId'],
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.createForm,
                    name: NavigationRoutes.createForm,
                    builder: (context, state) => const CreateFormScreen(),
                  ),
                  GoRoute(
                    path: NavigationRoutes.formEditer,
                    name: NavigationRoutes.formEditer,
                    builder: (context, state) => FormEditerScreen(
                      formId: state.uri.queryParameters['formId'],
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.welcomeForm,
                    name: NavigationRoutes.welcomeForm,
                    builder: (context, state) => const WelcomeFormScreen(),
                  ),
                  GoRoute(
                    path: NavigationRoutes.fillForm,
                    name: NavigationRoutes.fillForm,
                    builder: (context, state) => BlocProvider.value(
                      value: state.extra as FillFormCubit,
                      child: const FillFormScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.endForm,
                    name: NavigationRoutes.endForm,
                    builder: (context, state) => const EndFormScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                redirect: (context, state) async {
                  return await redirectToAuthorization();
                },
                path: '/${NavigationRoutes.profile}',
                name: NavigationRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Future<String?> redirectToAuthorization() async {
  final userId = await SharedPreferencesManager.getUserId();
  if (userId == null) {
    return '/${NavigationRoutes.welcome}/${NavigationRoutes.auth}';
  }
  return null;
}
