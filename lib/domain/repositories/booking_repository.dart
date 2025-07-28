import '../entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getAllBookings();
  Future<void> addBooking(Booking booking);
  Future<void> deleteBooking(String id);
}
