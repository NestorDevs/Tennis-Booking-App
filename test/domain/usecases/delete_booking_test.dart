import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_booking_app/domain/repositories/booking_repository.dart';
import 'package:tennis_booking_app/domain/usecases/delete_booking.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late DeleteBooking usecase;
  late MockBookingRepository mockBookingRepository;

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    usecase = DeleteBooking(mockBookingRepository);
  });

  const tBookingId = '1';

  test('should delete a booking from the repository', () async {
    // arrange
    when(() => mockBookingRepository.deleteBooking(any()))
        .thenAnswer((_) async => Future.value());
    // act
    await usecase(tBookingId);
    // assert
    verify(() => mockBookingRepository.deleteBooking(tBookingId)).called(1);
    verifyNoMoreInteractions(mockBookingRepository);
  });
}
