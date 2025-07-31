class OnboardingState {

  const OnboardingState({
    required this.currentPage,
    required this.isLast,
  });
  final int currentPage;
  final bool isLast;

  OnboardingState copyWith({
    int? currentPage,
    bool? isLast,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLast: isLast ?? this.isLast,
    );
  }
}
