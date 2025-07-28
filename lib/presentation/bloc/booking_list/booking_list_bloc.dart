import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_all_bookings.dart';
import '../../../domain/usecases/delete_booking.dart';
import 'booking_list_event.dart';
import 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  final GetAllBookings getAllBookings;
  final DeleteBooking deleteBooking;

  BookingListBloc({
    required this.getAllBookings,
    required this.deleteBooking,
  }) : super(BookingListLoading()) {
    on<LoadBookings>((event, emit) async {
      try {
        final bookings = await getAllBookings();
        emit(BookingListLoaded(bookings));
      } catch (e) {
        emit(BookingListError(e.toString()));
      }
    });

    on<DeleteBookingEvent>((event, emit) async {
      try {
        await deleteBooking(event.id);
        add(LoadBookings());
      } catch (e) {
        emit(BookingListError(e.toString()));
      }
    });
  }
}
