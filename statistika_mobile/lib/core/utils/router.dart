import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/authorization/view/authorization_screen.dart';
import 'package:statistika_mobile/features/form/view/forms_screen.dart';
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
                path: '/${NavigationRoutes.surveys}',
                name: NavigationRoutes.surveys,
                builder: (context, state) => const SurveyScreen(),
                routes: [
                  GoRoute(
                    path: '/${NavigationRoutes.forms}/:surveyId',
                    name: NavigationRoutes.forms,
                    builder: (context, state) => FormsScreen(
                      surveyId: state.pathParameters['surveyId'],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
