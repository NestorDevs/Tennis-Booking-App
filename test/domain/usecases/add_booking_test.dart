import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_booking_app/domain/entities/booking.dart';
import 'package:tennis_booking_app/domain/repositories/booking_repository.dart';
import 'package:tennis_booking_app/domain/usecases/add_booking.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late AddBooking usecase;
  late MockBookingRepository mockBookingRepository;

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    usecase = AddBooking(mockBookingRepository);
    registerFallbackValue(Booking(
      id: '1',
      courtName: 'A',
      date: DateTime.now(),
      userName: 'Test User',
      rainProbability: 50,
    ));
  });

  final tBooking = Booking(
      id: '1',
      courtName: 'A',
      date: DateTime.now(),
      userName: 'Test User',
      rainProbability: 50);

  test('should add a booking to the repository', () async {
    // arrange
    when(() => mockBookingRepository.addBooking(any()))
        .thenAnswer((_) async => Future.value());
    // act
    await usecase(tBooking);
    // assert
    verify(() => mockBookingRepository.addBooking(tBooking)).called(1);
    verifyNoMoreInteractions(mockBookingRepository);
  });
}