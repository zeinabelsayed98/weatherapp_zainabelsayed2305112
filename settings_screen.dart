import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SwitchListTile(
        title: Text('Use Metric Units (°C)'),
        subtitle: Text('Disable for Imperial (°F)'),
        value: provider.isMetric,
        onChanged: (val) {
          provider.toggleUnit();
        },
      ),
    );
  }
}