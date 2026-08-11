import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/booking_model.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/primary_button.dart';
import '../user_root_shell.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking booking;

  const BookingConfirmationScreen({super.key, required this.booking});

  void _goToShell(BuildContext context, int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => UserRootShell(initialIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.check_circle, color: AppColors.success, size: 84),
              const SizedBox(height: 20),
              Text('Booking Confirmed!', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text(
                'Your session has been scheduled successfully.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 28),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Row('Professional', booking.professional.name),
                    _Row('Service', '${booking.serviceCategoryName} · ${booking.durationMinutes} min'),
                    _Row('Date', '${booking.date.day}/${booking.date.month}/${booking.date.year}'),
                    _Row('Time', booking.time),
                    _Row('Address', booking.address),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1),
                    ),
                    _Row('Total paid', '₹${booking.totalPrice.toStringAsFixed(0)}', bold: true),
                    _Row('Booking ID', booking.bookingId),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'View My Bookings',
                onPressed: () => _goToShell(context, 1),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => _goToShell(context, 0),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text('Back to Home', textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _Row(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
