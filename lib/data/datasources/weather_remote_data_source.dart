import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

abstract class WeatherRemoteDataSource {
  Future<double> getRainProbability(DateTime date);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<double> getRainProbability(DateTime date) async {
    final apiKey = 'your API key'; // <-- IMPORTANT: Replace with your API key
    final url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=London&dt=${DateFormat('yyyy-MM-dd').format(date)}';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final hourlyForecasts =
          data['forecast']['forecastday'][0]['hour'] as List;

      if (hourlyForecasts.isEmpty) {
        return 0.0;
      }

      // Find the maximum chance of rain from the hourly forecast
      double maxRainProbability = 0.0;
      for (var hourData in hourlyForecasts) {
        final chanceOfRain = (hourData['chance_of_rain'] ?? 0).toDouble();
        if (chanceOfRain > maxRainProbability) {
          maxRainProbability = chanceOfRain;
        }
      }
      return maxRainProbability;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
