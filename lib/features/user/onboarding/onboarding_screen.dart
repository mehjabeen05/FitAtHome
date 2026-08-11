import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/primary_button.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _goToLogin(context),
                  child: const Text('Skip'),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Professional wellness at your doorstep',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const Text(
                'Book certified yoga, fitness and physiotherapy professionals for home sessions of 5 to 60 minutes — whenever it suits you.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 32),
              _OnboardRow(
                icon: Icons.self_improvement,
                title: 'Yoga',
                subtitle: 'Guided sessions for flexibility and calm.',
              ),
              const SizedBox(height: 20),
              _OnboardRow(
                icon: Icons.fitness_center,
                title: 'Fitness',
                subtitle: 'Personal training built around your goals.',
              ),
              const SizedBox(height: 20),
              _OnboardRow(
                icon: Icons.healing,
                title: 'Physiotherapy',
                subtitle: 'Recovery sessions with licensed physios.',
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => _goToLogin(context),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryTint,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
