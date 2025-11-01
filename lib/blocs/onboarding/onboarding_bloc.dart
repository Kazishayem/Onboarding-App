import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import 'package:onboarding_app/models/onboarding_page_model.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(OnboardingState(
          currentPage: 0,
          pages: const [
            OnboardingPageModel(
              image: 'assets/images/nature.jpg',
              title: 'Discover the world, one journey at a time.',
              subtitle:
                  'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable.',
            ),
            OnboardingPageModel(
              image: 'assets/images/travel.jpg',
              title: 'Sync with nature’s rhythm effortlessly.',
              subtitle:
                  'Let natural patterns inspire your routines and keep your days balanced and mindful.',
            ),
            OnboardingPageModel(
              image: 'assets/images/plane.jpg',
              title: 'Relax, unwind, and let life flow naturally.',
              subtitle:
                  'Stay in tune with the present moment and enjoy a peaceful lifestyle.',
            ),
          ],
        )) {
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
