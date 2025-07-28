import 'dart:math';

import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Booking>> getAllBookings() async {
    final bookings = await localDataSource.getAllBookings();
    bookings.sort((a, b) => a.date.compareTo(b.date));
    return bookings;
  }

  @override
  Future<void> addBooking(Booking booking) async {
    final bookings = await localDataSource.getAllBookings();

    final bookingsOnSameDate = bookings
        .where(
          (b) =>
              b.courtName == booking.courtName &&
              b.date.year == booking.date.year &&
              b.date.month == booking.date.month &&
              b.date.day == booking.date.day,
        )
        .toList();

    if (bookingsOnSameDate.length >= 3) {
      throw Exception('La cancha ya está reservada 3 veces para esta fecha.');
    }

    final newBooking = BookingModel(
      id: Random().nextInt(1000).toString(), // Generar un ID único
      courtName: booking.courtName,
      date: booking.date,
      userName: booking.userName,
      rainProbability: booking.rainProbability,
    );

    final updatedBookings = [...bookings, newBooking];
    await localDataSource.cacheBookings(updatedBookings);
  }

  @override
  Future<void> deleteBooking(String id) async {
    final bookings = await localDataSource.getAllBookings();
    final updatedBookings = bookings.where((b) => b.id != id).toList();
    await localDataSource.cacheBookings(updatedBookings);
  }
}
