import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/utils/router.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/user_profile_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/forms/cubit/forms_cubit.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/general_question_cubit.dart';
import 'package:statistika_mobile/features/home/cubit/question_types_cubit.dart';
import 'package:statistika_mobile/features/home/cubit/survey_roles_cubit.dart';
import 'package:statistika_mobile/features/home/cubit/survey_types_cubit.dart';
import 'package:statistika_mobile/features/survey/view/cubit/survey_cubit.dart';

import 'core/constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthorizationCubit(),
        ),

        //Основная часть
        BlocProvider(
          create: (context) => SurveyCubit(),
        ),
        BlocProvider(
          create: (context) => FormsCubit(),
        ),
        BlocProvider(
          create: (context) => ActiveFormCubit(),
        ),
        BlocProvider(
          create: (context) => UserProfileCubit(),
        ),
        BlocProvider(
          create: (context) => GeneralQuestionCubit(),
        ),

        //Классификации/справочники
        BlocProvider(
          create: (context) => QuestionTypesCubit()..update(),
        ),
        BlocProvider(
          create: (context) => SurveyRolesCubit()..update(),
        ),
        BlocProvider(
          create: (context) => SurveyTypesCubit()..update(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(),
        routerConfig: _router,
      ),
    );
  }
}
