import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_task/Config/routes/onboarding_screen.dart';
import 'package:store_task/Features/products/presentation/cubit/product_cubit';
import 'package:store_task/Features/products/presentation/screens/home_screen.dart';
import 'package:store_task/injection_container.dart' as di;
import 'package:store_task/Config/routes/routes.dart';
import 'package:store_task/Core/utils/app_strings.dart';

import 'animated_splash_screen.dart';

SharedPreferences sharedPreferences = di.sl();

chooseWhereToStart() {
  bool? isFirstTime = sharedPreferences.getBool(AppStrings.cachedFirstTimeBool);

  if (isFirstTime != null && isFirstTime) {
    return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
              value: di.sl<ProductCubit>(),
              child: HomeScreen(),
            ));
  } else {
    return MaterialPageRoute(
        builder: (context) => const AnimatedSplashScreen());
  }
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialOnboardRoute:
        return chooseWhereToStart();

      case Routes.splashScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const AnimatedSplashScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: di.sl<ProductCubit>(),
            child: const HomeScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
