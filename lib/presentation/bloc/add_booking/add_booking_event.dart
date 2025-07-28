import 'package:equatable/equatable.dart';
import '../../../domain/entities/booking.dart';

abstract class AddBookingEvent extends Equatable {
  const AddBookingEvent();

  @override
  List<Object> get props => [];
}

class AddBookingButtonPressed extends AddBookingEvent {
  final Booking booking;

  const AddBookingButtonPressed(this.booking);

  @override
  List<Object> get props => [booking];
}
