import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import 'package:onboarding_app/models/onboarding_page_model.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
    : super(
        OnboardingState(
          currentPage: 0,
          pages: const [
            OnboardingPageModel(
              image: 'assets/images/travel3.png',
              title: 'Discover the world, one journey at a time.',
              subtitle:
                  'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable.Start your next adventure today.',
            ),
            OnboardingPageModel(
              image: 'assets/images/travel6.png',
              title: 'Explore new horizons,one step at a time.',
              subtitle:
                  'Every trip holds a story waiting to be lived.Let us guide you to experiences that inspire,connect,and last a lifetime.',
            ),
            OnboardingPageModel(
              image: 'assets/images/travel.png',
              title: 'See the beauty,one journey at a time.',
              subtitle:
                  'Travel made simple and exciting-discover places you"ll never forget.',
            ),
          ],
        ),
      ) {
    on<OnPageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.pageIndex));
    });

    on<NextPagePressed>((event, emit) {
      final nextPage = (state.currentPage < state.pages.length - 1)
          ? state.currentPage + 1
          : state.currentPage;
      emit(state.copyWith(currentPage: nextPage));
    });

    on<SkipPressed>((event, emit) {
      emit(state.copyWith(currentPage: state.pages.length - 1));
    });
  }
}
