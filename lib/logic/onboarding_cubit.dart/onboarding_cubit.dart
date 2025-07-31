import 'package:cabibook/logic/onboarding_cubit.dart/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {

  OnboardingCubit({required this.totalPages})
      : super(const OnboardingState(currentPage: 0, isLast: false));
  final int totalPages;

  void changePage(int index) {
    emit(
      state.copyWith(
        currentPage: index,
        isLast: index == totalPages - 1,
      ),
    );
  }
  void nextPage() {
    if (state.currentPage < totalPages - 1) {
      changePage(state.currentPage + 1);
    }
  }
}
