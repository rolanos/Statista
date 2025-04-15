import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/authorization/view/authorization_screen.dart';
import 'package:statistika_mobile/features/authorization/view/profile_screen.dart';
import 'package:statistika_mobile/features/form/view/create_form/create_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/end_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/fill_form_screen.dart';
import 'package:statistika_mobile/features/form/view/form_editer/form_editer_screen.dart';
import 'package:statistika_mobile/features/form/view/forms/forms_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/welcome_form_screen.dart';
import 'package:statistika_mobile/features/home/home_screen.dart';
import 'package:statistika_mobile/features/survey/view/survey_screen.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: '/${NavigationRoutes.auth}',
    routes: [
      GoRoute(
        path: '/${NavigationRoutes.auth}',
        name: NavigationRoutes.auth,
        builder: (context, state) => const AuthorizationScreen(),
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
                builder: (context, state) => const Placeholder(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${NavigationRoutes.surveys}',
                name: NavigationRoutes.surveys,
                builder: (context, state) => const SurveyScreen(),
                routes: [
                  GoRoute(
                    path: '/${NavigationRoutes.forms}',
                    name: NavigationRoutes.forms,
                    builder: (context, state) => FormsScreen(
                      surveyId: state.uri.queryParameters['surveyId'],
                    ),
                    routes: [
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
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
