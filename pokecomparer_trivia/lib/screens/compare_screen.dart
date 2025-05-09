import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../controllers/pokemon_controller.dart';
import '../services/favorites_service.dart';
import 'home_screen.dart';
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
        title: const Text('Comparación de Pokémon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Ir al inicio',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen(resetSelection: true)),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                      ),
                      child: Image.network(pokemon1.imageUrl, width: 100, height: 100),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pokemon1.name.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(pokemon1.types.join(', '), style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const Text('VS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 3),
                      ),
                      child: Image.network(pokemon2.imageUrl, width: 100, height: 100),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pokemon2.name.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(pokemon2.types.join(', '), style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Comparación de estadísticas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final stat = data[group.x.toInt()]['stat'];
                        final value = rod.toY.toInt();
                        final label = rodIndex == 0
                            ? '$stat (${pokemon1.name.toUpperCase()}): $value'
                            : '$stat (${pokemon2.name.toUpperCase()}): $value';
                        return BarTooltipItem(
                          label,
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
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
                        color: Colors.red,
                      ),
                      BarChartRodData(
                        toY: (stat['pokemon2'] as int).toDouble(),
                        width: 8,
                        color: Colors.blue,
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                await FavoritesService.saveFavoriteComparison(pokemon1, pokemon2);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Guardado en favoritos!')),
                );
              },
              icon: const Icon(Icons.favorite_border),
              label: const Text('Guardar como favorito'),
            ),
          ],
        ),
      ),
    );
  }
}
