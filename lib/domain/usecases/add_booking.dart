import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class AddBooking {
  final BookingRepository repository;

  AddBooking(this.repository);

  Future<void> call(Booking booking) async {
    return repository.addBooking(booking);
  }
}