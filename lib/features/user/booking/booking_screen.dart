import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/mock_data.dart';
import '../../../models/professional_model.dart';
import '../../../models/booking_model.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/primary_button.dart';
import 'booking_confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Professional professional;

  const BookingScreen({super.key, required this.professional});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime _selectedDate;
  late String _selectedSlot;
  late int _selectedDuration;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedSlot = widget.professional.availableSlots.first;
    _selectedDuration = sessionDurations[1];
  }

  @override
  Widget build(BuildContext context) {
    final professional = widget.professional;
    final sessionPrice = professional.priceForDuration(_selectedDuration);
    final total = sessionPrice + travelFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Session')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          Text('Select date', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final date = DateTime.now().add(Duration(days: i));
                final selected = date.day == _selectedDate.day && date.month == _selectedDate.month;
                const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 56,
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[date.weekday - 1],
                          style: TextStyle(
                            fontSize: 11,
                            color: selected ? Colors.white70 : AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text('Select time slot', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: professional.availableSlots.map((slot) {
              final selected = slot == _selectedSlot;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlot = slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      fontSize: 13,
                      color: selected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('Session duration', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sessionDurations.map((duration) {
              final selected = duration == _selectedDuration;
              return GestureDetector(
                onTap: () => setState(() => _selectedDuration = duration),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                  ),
                  child: Text(
                    '$duration min',
                    style: TextStyle(
                      fontSize: 13,
                      color: selected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('Session address', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          AppCard(
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    mockCurrentUser.address,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Address editing coming soon')),
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Price breakdown', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                _PriceRow(label: 'Session price', value: sessionPrice),
                const SizedBox(height: 8),
                _PriceRow(label: 'Visit / travel fee', value: travelFee),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(height: 1),
                ),
                _PriceRow(label: 'Total', value: total, bold: true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: PrimaryButton(
            label: 'Confirm Booking',
            onPressed: () {
              final booking = Booking(
                id: 'local',
                professional: professional,
                serviceCategoryName: mockServiceCategories
                    .firstWhere((c) => professional.serviceCategoryIds.contains(c.id))
                    .name,
                date: _selectedDate,
                time: _selectedSlot,
                durationMinutes: _selectedDuration,
                address: mockCurrentUser.address,
                sessionPrice: sessionPrice,
                travelFee: travelFee,
                totalPrice: total,
                status: BookingStatus.upcoming,
                // Simple mock ID, unique enough for preview purposes only.
                bookingId: 'FAH-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
              );
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BookingConfirmationScreen(booking: booking)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;

  const _PriceRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 15 : 13,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      color: AppColors.textPrimary,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('₹${value.toStringAsFixed(0)}', style: style),
      ],
    );
  }
}
