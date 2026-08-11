import 'professional_model.dart';

enum BookingStatus { upcoming, completed, cancelled, pending }

class Booking {
  final String id;
  final Professional professional;
  final String serviceCategoryName;
  final DateTime date;
  final String time;
  final int durationMinutes;
  final String address;
  final double sessionPrice;
  final double travelFee;
  final double totalPrice;
  final BookingStatus status;
  final String bookingId;

  const Booking({
    required this.id,
    required this.professional,
    required this.serviceCategoryName,
    required this.date,
    required this.time,
    required this.durationMinutes,
    required this.address,
    required this.sessionPrice,
    required this.travelFee,
    required this.totalPrice,
    required this.status,
    required this.bookingId,
  });
}
