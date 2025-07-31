import 'package:cabibook/logic/onboarding_cubit.dart/onboarding_cubit.dart';
import 'package:cabibook/logic/onboarding_cubit.dart/onboarding_state.dart';
import 'package:cabibook/model/onboarding_model.dart';
import 'package:cabibook/presentation/auth/authtabs.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: OnboardingItem.items.length,
            onPageChanged: cubit.changePage,
            itemBuilder: (context, index) {
              final item = OnboardingItem.items[index];
              return Stack(
                children: [
                  Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withValues(alpha:  0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                  Container(color: context.primaryColor.withValues(alpha:  0.4)),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                final item = OnboardingItem.items[state.currentPage];
                return Container(
                  padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 40.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: context.textTheme.bodyLarge!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 50.h,
                        child: Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: context.textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                 26.hsb,
                      ApplicationButton(
                        onPressed: () {
                          if (state.isLast) {
                            context.pushReplacement(const LoginView());
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        size: Size(double.infinity, 50.h),
                        child: Text(
                          state.isLast
                              ? ApplicationStrings.getStarted
                              : ApplicationStrings.continueButton,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                      20.hsb,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          OnboardingItem.items.length,
                          (index) => _dot(active: index == state.currentPage),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot({bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: active ? 25.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFBE045E) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
