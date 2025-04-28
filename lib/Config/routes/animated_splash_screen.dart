import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:store_task/Config/routes/routes.dart';
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
      body: Directionality(
        // Wrap with Directionality for RTL support
        textDirection: TextDirection.ltr, // Set to RTL for Arabic
        child: Center(
          child: TextAnimator(
            'Store Task', // Arabic text for "Store Task"
            style: TextStyle(
              fontSize: 70.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right, // Right align for Arabic
          )
              .animate()
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(0.8, 0.8),
                duration: 300.ms,
                curve: Curves.elasticIn,
                transformHitTests: true,
              )
              .then()
              .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
                duration: 300.ms,
                curve: Curves.elasticIn,
                transformHitTests: true,
              ),
        ),
      ),
    );
  }
}
