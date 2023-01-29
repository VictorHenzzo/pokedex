class PokemonSpeciesEntity {
  PokemonSpeciesEntity({
    required this.name,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.flavorText,
  });

  final String name;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String flavorText;
}
