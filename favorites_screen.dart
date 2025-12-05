import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final favs = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favs.isEmpty
          ? Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final city = favs[index];
                return ListTile(
                  title: Text(city),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    provider.searchCity(city);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen()));
                  },
                );
              },
            ),
    );
  }
}