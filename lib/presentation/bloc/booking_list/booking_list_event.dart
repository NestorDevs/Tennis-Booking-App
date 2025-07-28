import 'package:equatable/equatable.dart';

abstract class BookingListEvent extends Equatable {
  const BookingListEvent();

  @override
  List<Object> get props => [];
}

class LoadBookings extends BookingListEvent {}

class DeleteBookingEvent extends BookingListEvent {
  final String id;

  const DeleteBookingEvent(this.id);

  @override
  List<Object> get props => [id];
}
