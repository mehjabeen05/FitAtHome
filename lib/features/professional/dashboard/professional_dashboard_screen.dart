import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../shared/widgets/app_card.dart';

class ProfessionalDashboardScreen extends StatefulWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  State<ProfessionalDashboardScreen> createState() => _ProfessionalDashboardScreenState();
}

class _PendingRequest {
  final String clientName;
  final String service;
  final String time;
  bool handled;

  _PendingRequest({
    required this.clientName,
    required this.service,
    required this.time,
    this.handled = false,
  });
}

class _ProfessionalDashboardScreenState extends State<ProfessionalDashboardScreen> {
  final List<_PendingRequest> _requests = [
    _PendingRequest(clientName: 'Aisha Verma', service: 'Yoga · 30 min', time: 'Today, 5:30 PM'),
    _PendingRequest(clientName: 'Rahul Deshmukh', service: 'Yoga · 15 min', time: 'Tomorrow, 8:00 AM'),
  ];

  void _respond(_PendingRequest request, String action) {
    setState(() => request.handled = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request $action for ${request.clientName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final professional = mockProfessionals.first;
    final upcoming = mockBookings.take(2).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        children: [
          Text('Good morning, ${professional.name.split(' ').first}', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          const Text(
            'Here is what today looks like.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _StatCard(label: "Today's Sessions", value: '3')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(label: "This Week", value: '₹4,250')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'Rating', value: professional.rating.toStringAsFixed(1))),
            ],
          ),
          const SizedBox(height: 24),
          Text('Pending Requests', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._requests.map((request) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.clientName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 3),
                      Text('${request.service} · ${request.time}',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      const SizedBox(height: 10),
                      if (request.handled)
                        const Text('Response sent', style: TextStyle(color: AppColors.textMuted, fontSize: 12))
                      else
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _respond(request, 'rejected'),
                                child: const Text('Reject'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _respond(request, 'accepted'),
                                child: const Text('Accept'),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 12),
          Text('Upcoming Sessions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...upcoming.map((booking) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.serviceCategoryName,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            const SizedBox(height: 3),
                            Text(
                              '${booking.durationMinutes} min · ${booking.time}',
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Session started')),
                        ),
                        child: const Text('Start Session'),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
