import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/Config/theme/app_theme.dart';
import 'Config/locale/app_localizations_setup.dart';
import 'Config/routes/app_routes.dart';
import 'Config/routes/routes.dart';
import 'Core/utils/app_strings.dart';
import 'package:store_task/injection_container.dart' as di;

import 'Features/settings/presentation/cubit/locale/locale_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return BlocProvider.value(
          value: di.sl<LocaleCubit>()..getSavedLang(),
          child: BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (context, localState) {
              return MaterialApp(
                locale: di.sl<LocaleCubit>().locale,
                debugShowCheckedModeBanner: false,
                themeAnimationStyle: AnimationStyle(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    curve: Curves.easeInOut),
                title: AppStrings.appName,
                theme: AppThemeStyle.lightTheme,
                initialRoute: Routes.initialOnboardRoute,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
              );
            },
          ),
        );
      },
    );
  }
}
