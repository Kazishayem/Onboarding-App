import 'package:equatable/equatable.dart';
import 'package:onboarding_app/models/onboarding_page_model.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final List<OnboardingPageModel> pages;

  const OnboardingState({
    required this.currentPage,
    required this.pages,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPageModel>? pages,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
    );
  }

  @override
  List<Object?> get props => [currentPage, pages];
}
