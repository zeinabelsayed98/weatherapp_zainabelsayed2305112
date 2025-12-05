import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/weather_model.dart';

class WeatherService {
  // ⚠️ مهم: حط مفتاح الـ API بتاعك هنا
  static const String apiKey = 'c4b4e3fbdb3ebb656100407163fc750a';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeather(String city, {bool isMetric = true}) async {
    final units = isMetric ? 'metric' : 'imperial';
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=$units');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}