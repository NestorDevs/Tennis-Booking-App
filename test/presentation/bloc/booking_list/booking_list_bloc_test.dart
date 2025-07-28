import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tennis_booking_app/domain/entities/booking.dart';
import 'package:tennis_booking_app/domain/usecases/get_all_bookings.dart';
import 'package:tennis_booking_app/domain/usecases/delete_booking.dart';
import 'package:tennis_booking_app/presentation/bloc/booking_list/booking_list_bloc.dart';
import 'package:tennis_booking_app/presentation/bloc/booking_list/booking_list_event.dart';
import 'package:tennis_booking_app/presentation/bloc/booking_list/booking_list_state.dart';

import 'booking_list_bloc_test.mocks.dart';

@GenerateMocks([GetAllBookings, DeleteBooking])
void main() {
  group('BookingListBloc', () {
    late MockGetAllBookings mockGetAllBookings;
    late MockDeleteBooking mockDeleteBooking;
    late BookingListBloc bookingListBloc;

    setUp(() {
      mockGetAllBookings = MockGetAllBookings();
      mockDeleteBooking = MockDeleteBooking();
      bookingListBloc = BookingListBloc(
        getAllBookings: mockGetAllBookings,
        deleteBooking: mockDeleteBooking,
      );
    });

    final tBooking = Booking(
      id: '1',
      courtName: 'Test Court',
      userName: 'Test User',
      date: DateTime.now(),
      rainProbability: 10.0,
    );

    test('initial state is BookingListLoading', () {
      expect(bookingListBloc.state, BookingListLoading());
    });

    blocTest<BookingListBloc, BookingListState>(
      'emits [BookingListLoaded] when LoadBookings is added',
      build: () {
        when(mockGetAllBookings.call()).thenAnswer((_) async => [tBooking]);
        return bookingListBloc;
      },
      act: (bloc) => bloc.add(LoadBookings()),
      expect: () => [
        BookingListLoaded([tBooking]),
      ],
    );

    blocTest<BookingListBloc, BookingListState>(
      'emits [BookingListLoaded] when DeleteBookingEvent is added',
      build: () {
        when(mockDeleteBooking.call('1')).thenAnswer((_) async => Future.value());
        when(mockGetAllBookings.call()).thenAnswer((_) async => []);
        return bookingListBloc;
      },
      act: (bloc) => bloc.add(DeleteBookingEvent('1')),
      expect: () => [
        BookingListLoaded([]),
      ],
      verify: (_) {
        verify(mockDeleteBooking.call('1')).called(1);
        verify(mockGetAllBookings.call()).called(1);
      },
    );
  });
}
