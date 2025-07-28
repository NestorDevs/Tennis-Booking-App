import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_booking_app/domain/repositories/weather_repository.dart';
import 'package:tennis_booking_app/domain/usecases/get_rain_probability.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetRainProbability usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetRainProbability(mockWeatherRepository);
    registerFallbackValue(DateTime.now());
  });

  final tDate = DateTime.now();
  const tRainProbability = 0.5;

  test('should get rain probability from the repository', () async {
    // arrange
    when(() => mockWeatherRepository.getRainProbability(any()))
        .thenAnswer((_) async => tRainProbability);
    // act
    final result = await usecase(tDate);
    // assert
    expect(result, tRainProbability);
    verify(() => mockWeatherRepository.getRainProbability(tDate))
        .called(1);
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}