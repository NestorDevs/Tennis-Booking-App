import 'package:equatable/equatable.dart';
import '../../../domain/entities/booking.dart';

abstract class BookingListState extends Equatable {
  const BookingListState();

  @override
  List<Object> get props => [];
}

class BookingListLoading extends BookingListState {}

class BookingListLoaded extends BookingListState {
  final List<Booking> bookings;

  const BookingListLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingListError extends BookingListState {
  final String message;

  const BookingListError(this.message);

  @override
  List<Object> get props => [message];
}
