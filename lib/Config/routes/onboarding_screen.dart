import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_task/Config/routes/app_routes.dart';
import 'package:store_task/Config/routes/routes.dart';
import 'package:store_task/Core/utils/app_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingData.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = OnboardingData.pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page.image,
                          height: 300,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: OnboardingData.pages.length,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton(
                onPressed: () async {
                  if (_currentPage == OnboardingData.pages.length - 1) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    await sharedPreferences.setBool(
                        AppStrings.cachedFirstTimeBool, true);
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.homeScreen);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Text(
                  _currentPage == OnboardingData.pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
                },
                child: const Text('Skip'),
              ),
            ]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  static final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/onboarding1.png',
      title: 'Purchase online',
      description: 'Discover amazing features that will make your life easier.',
    ),
    OnboardingModel(
      image: 'assets/onboarding2.png',
      title: 'Track your order',
      description: 'Simple and intuitive interface for all users.',
    ),
    OnboardingModel(
      image: 'assets/onboarding3.png',
      title: 'Get your order',
      description: 'Join thousands of happy users today!',
    ),
  ];
}

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
