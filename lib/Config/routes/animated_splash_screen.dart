import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:store_task/Config/routes/routes.dart';
import 'package:store_task/Core/extensions/extensions.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    super.initState();
    fun();

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Please don\'t delete me ☹️',
      ),
    ]);
  }

  String shortcut = 'no action set';

  fun() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: TextAnimator(
        'Store Task'.translate(context),
        style: const TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.w700,
        ),
      )
              .animate()
              .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(0.8, 0.8),
                  duration: 300.ms,
                  curve: Curves.elasticIn,
                  transformHitTests: true) // Scale down
              .then()
              .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 300.ms,
                  curve: Curves.elasticIn,
                  transformHitTests: true) // Scale back up
          // .show(), // Repeat the animation
          ),
    );
  }
}
