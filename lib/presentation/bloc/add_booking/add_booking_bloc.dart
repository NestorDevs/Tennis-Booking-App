import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_booking.dart';
import '../../../domain/usecases/get_rain_probability.dart';
import 'add_booking_event.dart';
import 'add_booking_state.dart';

class AddBookingBloc extends Bloc<AddBookingEvent, AddBookingState> {
  final AddBooking addBooking;
  final GetRainProbability getRainProbability;

  AddBookingBloc({
    required this.addBooking,
    required this.getRainProbability,
  }) : super(AddBookingInitial()) {
    on<AddBookingButtonPressed>((event, emit) async {
      emit(AddBookingLoading());
      try {
        final rainProbability = await getRainProbability(event.booking.date);
        final newBooking = event.booking.copyWith(rainProbability: rainProbability);
        await addBooking(newBooking);
        emit(AddBookingSuccess());
      } catch (e) {
        emit(AddBookingFailure(e.toString()));
      }
    });
  }
}