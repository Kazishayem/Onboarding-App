// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String>> pages = [
//     {
//       'image': 'assets/images/nature.jpg',
//       'title': 'Discover the world, one journey at a time.',
//       'subtitle':
//           'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable.',
//     },
//     {
//       'image': 'assets/images/travel.jpg',
//       'title': 'Sync with nature’s rhythm effortlessly.',
//       'subtitle':
//           'Let natural patterns inspire your routines and keep your days balanced and mindful.',
//     },
//     {
//       'image': 'assets/images/plane.jpg',
//       'title': 'Relax, unwind, and let life flow naturally.',
//       'subtitle':
//           'Stay in tune with the present moment and enjoy a peaceful lifestyle.',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         /// ✅ FULL SCREEN GRADIENT BACKGROUND
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color.fromARGB(255, 99, 52, 166), Color(0xff000000)],
//           ),
//         ),

//         /// ✅ STACK TO HOLD PAGEVIEW + CONTROLS
//         child: Stack(
//           children: [
//             /// ✅ PAGEVIEW (without SafeArea)
//             PageView.builder(
//               controller: _pageController,
//               itemCount: pages.length,
//               onPageChanged: (index) {
//                 setState(() => _currentPage = index);
//               },
//               itemBuilder: (_, index) {
//                 return _buildPage(
//                   image: pages[index]['image']!,
//                   title: pages[index]['title']!,
//                   subtitle: pages[index]['subtitle']!,
//                 );
//               },
//             ),

//             /// ✅ SAFEAREA FOR OVERLAY ELEMENTS (SKIP + DOTS + BUTTON)
//             SafeArea(
//               child: Stack(
//                 children: [
//                   /// ✅ SKIP BUTTON
//                   Positioned(
//                     top: 20,
//                     right: 16,
//                     child: TextButton(
//                       onPressed: () {
//                         _pageController.jumpToPage(pages.length - 1);
//                       },
//                       child: const Text(
//                         'Skip',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),

//                   /// ✅ DOTS + NEXT/GET STARTED BUTTON
//                   Positioned(
//                     bottom: 30,
//                     left: 0,
//                     right: 0,
//                     child: Column(
//                       children: [
//                         /// ✅ DOT INDICATORS
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             pages.length,
//                             (index) => AnimatedContainer(
//                               duration: const Duration(milliseconds: 200),
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               height: 8,
//                               width: _currentPage == index ? 22 : 8,
//                               decoration: BoxDecoration(
//                                 color: _currentPage == index
//                                     ? Colors.white
//                                     : Colors.white38,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         /// ✅ NEXT / GET STARTED BUTTON
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.purple,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               minimumSize: const Size(double.infinity, 55),
//                             ),
//                             onPressed: () {
//                               if (_currentPage < pages.length - 1) {
//                                 _pageController.nextPage(
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeInOut,
//                                 );
//                               } else {
//                                 Navigator.pushReplacementNamed(
//                                   context,
//                                   '/home',
//                                 );
//                               }
//                             },
//                             child: Text(
//                               _currentPage == pages.length - 1
//                                   ? 'Get Started'
//                                   : 'Next',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ SINGLE PAGE DESIGN
//   Widget _buildPage({
//     required String image,
//     required String title,
//     required String subtitle,
//   }) {
//     return Column(
//       children: [
//         /// ✅ FULL TOP IMAGE (COVERS STATUS BAR AREA)
//         ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(40),
//             bottomRight: Radius.circular(40),
//           ),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.55,
//             width: double.infinity,
//             child: Image.asset(image, fit: BoxFit.cover),
//           ),
//         ),

//         /// ✅ TEXT CONTENT
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 15,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
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
                  colors: [Color.fromARGB(255, 99, 52, 166), Color(0xff000000)],
                ),
              ),
              child: Stack(
                children: [
                  /// ✅ PAGEVIEW
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

                  /// ✅ Overlay UI
                  SafeArea(
                    child: Stack(
                      children: [
                        /// ✅ Skip Button
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        /// ✅ Dots + Next Button
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
                                    width: state.currentPage == index ? 22 : 8,
                                    decoration: BoxDecoration(
                                      color: state.currentPage == index
                                          ? Colors.white
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
                                    backgroundColor: Colors.purple,
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
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
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
