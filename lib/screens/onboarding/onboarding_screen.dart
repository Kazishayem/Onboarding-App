import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:onboarding_app/blocs/onboarding/onboarding_event.dart';
import 'package:onboarding_app/blocs/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 20, 14, 68),
                    Color.fromARGB(255, 19, 15, 74),
                  ],
                ),
              ),
              child: Stack(
                children: [
                
                  PageView.builder(
                    controller: _pageController,
                    itemCount: state.pages.length,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(OnPageChanged(index));
                    },
                    itemBuilder: (_, index) {
                      final page = state.pages[index];
                      return _buildPage(
                        context,
                        image: page.image,
                        title: page.title,
                        subtitle: page.subtitle,
                      );
                    },
                  ),

                
                  SafeArea(
                    child: Stack(
                      children: [
                      
                        Positioned(
                          top: 20,
                          right: 16,
                          child: TextButton(
                            onPressed: () {
                              context.read<OnboardingBloc>().add(SkipPressed());
                              _pageController.jumpToPage(
                                state.pages.length - 1,
                              );
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                      
                        Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  state.pages.length,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    height: 8,
                                    width: state.currentPage == index ? 8 : 10,
                                    decoration: BoxDecoration(
                                      color: state.currentPage == index
                                          ? const Color.fromARGB(
                                              255,
                                              66,
                                              16,
                                              181,
                                            )
                                          : Colors.white38,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      66,
                                      16,
                                      181,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      55,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (state.currentPage <
                                        state.pages.length - 1) {
                                      context.read<OnboardingBloc>().add(
                                        NextPagePressed(),
                                      );
                                      _pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    }
                                  },
                                  child: Text(
                                    state.currentPage == state.pages.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  title,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    wordSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,

                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'Poppins',
                    wordSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
