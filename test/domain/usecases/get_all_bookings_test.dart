import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_booking_app/domain/entities/booking.dart';
import 'package:tennis_booking_app/domain/repositories/booking_repository.dart';
import 'package:tennis_booking_app/domain/usecases/get_all_bookings.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late GetAllBookings usecase;
  late MockBookingRepository mockBookingRepository;

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    usecase = GetAllBookings(mockBookingRepository);
  });

  final tBookings = [
    Booking(
      id: '1',
      courtName: 'A',
      date: DateTime.now(),
      userName: 'Test User',
      rainProbability: 50,
    )
  ];

  test('should get all bookings from the repository', () async {
    // arrange
    when(() => mockBookingRepository.getAllBookings())
        .thenAnswer((_) async => tBookings);
    // act
    final result = await usecase.call();
    // assert
    expect(result, tBookings);
    verify(() => mockBookingRepository.getAllBookings()).called(1);
    verifyNoMoreInteractions(mockBookingRepository);
  });
}
