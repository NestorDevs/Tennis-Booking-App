import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetAllBookings {
  final BookingRepository repository;

  GetAllBookings(this.repository);

  Future<List<Booking>> call() {
    return repository.getAllBookings();
  }
}
