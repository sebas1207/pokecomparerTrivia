import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../controllers/pokemon_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class CompareScreen extends StatelessWidget {
  final Pokemon pokemon1;
  final Pokemon pokemon2;

  const CompareScreen({super.key, required this.pokemon1, required this.pokemon2});

  @override
  Widget build(BuildContext context) {
    final controller = PokemonController(pokemon1: pokemon1, pokemon2: pokemon2);
    final data = controller.getComparisonData();

    return Scaffold(
      appBar: AppBar(
        title: Text('${pokemon1.name.toUpperCase()} vs ${pokemon2.name.toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 200,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() < data.length) {
                      return Text(data[value.toInt()]['stat']);
                    } else {
                      return const Text('');
                    }
                  },
                ),
              ),
            ),
            barGroups: data.asMap().entries.map((entry) {
              int index = entry.key;
              var stat = entry.value;
              return BarChartGroupData(x: index, barRods: [
                BarChartRodData(
                  toY: (stat['pokemon1'] as int).toDouble(),
                  width: 8,
                  color: Colors.blue,
                ),
                BarChartRodData(
                  toY: (stat['pokemon2'] as int).toDouble(),
                  width: 8,
                  color: Colors.red,
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
