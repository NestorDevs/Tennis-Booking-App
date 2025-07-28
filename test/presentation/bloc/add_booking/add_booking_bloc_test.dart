import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tennis_booking_app/domain/entities/booking.dart';
import 'package:tennis_booking_app/domain/usecases/add_booking.dart';
import 'package:tennis_booking_app/domain/usecases/get_rain_probability.dart';
import 'package:tennis_booking_app/presentation/bloc/add_booking/add_booking_bloc.dart';
import 'package:tennis_booking_app/presentation/bloc/add_booking/add_booking_event.dart';
import 'package:tennis_booking_app/presentation/bloc/add_booking/add_booking_state.dart';

import 'add_booking_bloc_test.mocks.dart';

@GenerateMocks([AddBooking, GetRainProbability])
void main() {
  group('AddBookingBloc', () {
    late MockAddBooking mockAddBooking;
    late MockGetRainProbability mockGetRainProbability;
    late AddBookingBloc addBookingBloc;
    final tDate = DateTime(2025, 7, 28);
    final tBooking = Booking(
      id: '1',
      courtName: 'Test Court',
      userName: 'Test User',
      date: tDate,
      rainProbability: 0, // Rain probability is calculated by the bloc
    );

    setUp(() {
      mockAddBooking = MockAddBooking();
      mockGetRainProbability = MockGetRainProbability();
      addBookingBloc = AddBookingBloc(
        addBooking: mockAddBooking,
        getRainProbability: mockGetRainProbability,
      );
    });

    test('initial state is AddBookingInitial', () {
      expect(addBookingBloc.state, AddBookingInitial());
    });

    blocTest<AddBookingBloc, AddBookingState>(
      'emits [AddBookingLoading, AddBookingSuccess] when AddBookingButtonPressed is added',
      build: () {
        final tBookingWithRain = tBooking.copyWith(rainProbability: 10.0);
        when(mockGetRainProbability.call(tDate)).thenAnswer((_) async => 10.0);
        when(mockAddBooking.call(tBookingWithRain)).thenAnswer((_) async => Future.value());
        return addBookingBloc;
      },
      act: (bloc) => bloc.add(AddBookingButtonPressed(tBooking)),
      expect: () => [
        AddBookingLoading(),
        AddBookingSuccess(),
      ],
      verify: (_) {
        final tBookingWithRain = tBooking.copyWith(rainProbability: 10.0);
        verify(mockGetRainProbability.call(tDate)).called(1);
        verify(mockAddBooking.call(tBookingWithRain)).called(1);
      },
    );
  });
}
