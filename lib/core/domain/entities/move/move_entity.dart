class MoveEntity {
  MoveEntity({
    required this.name,
    required this.accuracy,
    required this.effectChance,
    required this.powerPoints,
    required this.power,
    required this.damageClass,
    required this.effectEntries,
    required this.learnedByPokemon,
    required this.flavorText,
  });

  final String name;
  final int accuracy;
  final int? effectChance;
  final int powerPoints;
  final int power;
  final String damageClass;
  final List<String>? effectEntries;
  final List<String> learnedByPokemon;
  final String flavorText;
}
