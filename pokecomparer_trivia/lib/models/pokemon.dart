class Pokemon {
  final String name;
  final String imageUrl;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List stats = json['stats'];

    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      hp: stats[0]['base_stat'],
      attack: stats[1]['base_stat'],
      defense: stats[2]['base_stat'],
      specialAttack: stats[3]['base_stat'],
      specialDefense: stats[4]['base_stat'],
      speed: stats[5]['base_stat'],
    );
  }
}
