import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/routing/app_router.dart';
import '../../application/onboarding_cubit.dart';
import '../../application/user_use_cases.dart';
import '../widgets/onboarding_step_constraints.dart';
import '../widgets/onboarding_step_goals.dart';
import '../widgets/onboarding_step_metrics.dart';

class const OnboardingScreen({
  super.key,
  required final UserUseCases useCases,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState() extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingSteps = [
    {
      'animation': 'assets/animations/welcome.json',
      'title': 'Body Metrics & Profile',
      'description': 'Configure your core measurements and unit preferences.',
    },
    {
      'animation': 'assets/animations/counters.json',
      'title': 'Training Goals',
      'description':
          'Select your primary targets to track success effectively.',
    },
    {
      'animation': 'assets/animations/timers.json',
      'title': 'Constraints & Equipment',
      'description': 'Set your available equipment and session limits.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(widget.useCases, userId: widget.userId),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
              if (state.isCompleted) {
                context.go(appRouteHome);
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                        context.read<OnboardingCubit>().setStep(index);
                      },
                      itemCount: _onboardingSteps.length,
                      itemBuilder: (context, index) {
                        final step = _onboardingSteps[index];
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                step['animation']!,
                                width: 140,
                                height: 140,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.fitness_center, size: 80),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                step['title']!,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                step['description']!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 24),
                              // ── Render Step-Specific Forms ─────────────────
                              Expanded(
                                child: switch (index) {
                                  0 => const OnboardingStepMetrics(),
                                  1 => const OnboardingStepGoals(),
                                  2 => const OnboardingStepConstraints(),
                                  _ => const SizedBox.shrink(),
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _currentPage == 0
                              ? null
                              : () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                          child: const Text('Back'),
                        ),
                        FilledButton(
                          onPressed: () {
                            if (_currentPage == _onboardingSteps.length - 1) {
                              context
                                  .read<OnboardingCubit>()
                                  .completeOnboarding();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            _currentPage == _onboardingSteps.length - 1
                                ? 'Get Started'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
