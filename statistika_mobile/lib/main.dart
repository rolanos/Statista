import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/router.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/form/view/cubit/form_cubit.dart';
import 'package:statistika_mobile/features/form/view/forms_screen.dart';
import 'package:statistika_mobile/features/home/home_screen.dart';
import 'package:statistika_mobile/features/survey/view/cubit/survey_cubit.dart';

import 'core/constants/constants.dart';
import 'features/authorization/view/authorization_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthorizationCubit(),
        ),
        BlocProvider(
          create: (context) => SurveyCubit(),
        ),
        BlocProvider(
          create: (context) => FormsCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(),
        routerConfig: router,
      ),
    );
  }
}
