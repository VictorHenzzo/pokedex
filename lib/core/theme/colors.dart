import 'package:flutter/material.dart';
import 'package:pokedex/core/domain/entities/pokemon/pokemon_type_entity.dart';

class Colors {
  static Color getColorByPokemonTyp(final PokemonTypeEntity type) {
    return _colorByType[type.name] ?? const Color(0XFF68a090);
  }

  static const Map<String, Color> _colorByType = {
    'normal': Color(0xFFA8A77A),
    'fighting': Color(0xFFC22E28),
    'flying': Color(0xFFA98FF3),
    'poison': Color(0xFFA33EA1),
    'ground': Color(0xFFE2BF65),
    'rock': Color(0xFFB6A136),
    'bug': Color(0xFFA6B91A),
    'ghost': Color(0xFF735797),
    'steel': Color(0xFFB7B7CE),
    'fire': Color(0xFFEE8130),
    'water': Color(0xFF6390F0),
    'grass': Color(0xFF7AC74C),
    'electric': Color(0xFFF7D02C),
    'psychic': Color(0xFFF95587),
    'ice': Color(0xFF96D9D6),
    'dragon': Color(0xFF6F35FC),
    'dark': Color(0xFF705746),
    'fairy': Color(0xFFD685AD),
  };
}
