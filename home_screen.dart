import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/weather_provider.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen())),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .searchCity(_controller.text);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen()));
                    }
                  },
                ),
              ),
              onSubmitted: (val) {
                 if (val.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false).searchCity(val);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen()));
                 }
              },
            ),
            SizedBox(height: 20),
            Text("Search for a city to see weather details", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}