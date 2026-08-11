import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../models/booking_model.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/status_chip.dart';

class ProfessionalBookingsScreen extends StatefulWidget {
  const ProfessionalBookingsScreen({super.key});

  @override
  State<ProfessionalBookingsScreen> createState() => _ProfessionalBookingsScreenState();
}

class _ProfessionalBookingsScreenState extends State<ProfessionalBookingsScreen> {
  final Set<String> _startedIds = {};

  @override
  Widget build(BuildContext context) {
    final bookings = mockBookings;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Bookings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: bookings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final booking = bookings[i];
                  final started = _startedIds.contains(booking.id);
                  return AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(booking.serviceCategoryName,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            StatusChip(status: booking.status),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${booking.durationMinutes} min · ${booking.date.day}/${booking.date.month}/${booking.date.year} · ${booking.time}',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                        if (booking.status == BookingStatus.upcoming) ...[
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (started) {
                                    _startedIds.remove(booking.id);
                                  } else {
                                    _startedIds.add(booking.id);
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(started ? 'Session ended' : 'Session started')),
                                );
                              },
                              child: Text(started ? 'End Session' : 'Start Session'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
