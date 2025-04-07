import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const AuthorizationScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
