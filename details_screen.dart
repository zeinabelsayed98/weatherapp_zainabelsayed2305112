import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Details')),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.error.isNotEmpty) {
            return Center(child: Text(provider.error));
          }
          if (provider.currentWeather == null) {
            return Center(child: Text('No Data'));
          }

          final weather = provider.currentWeather!;
          final isFav = provider.isFavorite(weather.cityName);
          final unit = provider.isMetric ? "°C" : "°F";

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weather.cityName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Image.network('https://openweathermap.org/img/wn/${weather.iconCode}@2x.png'),
                Text('${weather.temperature.toStringAsFixed(1)} $unit', style: TextStyle(fontSize: 40)),
                Text(weather.description, style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text('Humidity: ${weather.humidity}%'),
                Text('Wind: ${weather.windSpeed}'),
                Text('Feels Like: ${weather.feelsLike} $unit'),
                SizedBox(height: 30),
                IconButton(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 40),
                  onPressed: () {
                    provider.toggleFavorite(weather.cityName);
                  },
                ),
                Text(isFav ? "Saved to Favorites" : "Add to Favorites")
              ],
            ),
          );
        },
      ),
    );
  }
}