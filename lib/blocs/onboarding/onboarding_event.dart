import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnPageChanged extends OnboardingEvent {
  final int pageIndex;
  const OnPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class NextPagePressed extends OnboardingEvent {}

class SkipPressed extends OnboardingEvent {}
