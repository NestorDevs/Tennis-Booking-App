import '../repositories/weather_repository.dart';

class GetRainProbability {
  final WeatherRepository repository;

  GetRainProbability(this.repository);

  Future<double> call(DateTime date) async {
    return await repository.getRainProbability(date);
  }
}