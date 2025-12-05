import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/weather_model.dart';
import '../../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _service = WeatherService();
  WeatherModel? _currentWeather;
  bool _isLoading = false;
  String _error = '';
  bool _isMetric = true; // True = Celsius, False = Fahrenheit
  List<String> _favorites = [];

  WeatherModel? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isMetric => _isMetric;
  List<String> get favorites => _favorites;

  // تحميل الإعدادات والمفضلة عند فتح التطبيق
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isMetric = prefs.getBool('isMetric') ?? true;
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  // البحث عن مدينة
  Future<void> searchCity(String city) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _currentWeather = await _service.getWeather(city, isMetric: _isMetric);
    } catch (e) {
      _error = 'Could not fetch weather. Check city name or internet.';
      _currentWeather = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // تغيير الوحدة (C/F)
  void toggleUnit() async {
    _isMetric = !_isMetric;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isMetric', _isMetric);
    
    // لو في مدينة معروضة، حدث بياناتها بالوحدة الجديدة
    if (_currentWeather != null) {
      searchCity(_currentWeather!.cityName);
    }
    notifyListeners();
  }

  // إدارة المفضلة
  void toggleFavorite(String city) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favorites.contains(city)) {
      _favorites.remove(city);
    } else {
      _favorites.add(city);
    }
    prefs.setStringList('favorites', _favorites);
    notifyListeners();
  }
  
  bool isFavorite(String city) {
    return _favorites.contains(city);
  }
}