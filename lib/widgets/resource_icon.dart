import 'package:flutter/material.dart';

class ResourceIcon extends StatelessWidget {
  final int resourceId;
  final String resourceType;
  final String identifier;

  final double scale;

  final String urlBase = "https://image.pokemonle.incubator4.com";

  const ResourceIcon({
    super.key,

    required this.resourceId,
    required this.resourceType,
    required this.identifier,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (resourceType) {
      case "pokemon-species":
        return FadeInImage(
          placeholder: AssetImage("assets/pokemon_placeholder.png"),
          image: NetworkImage("$urlBase/pokemon/$resourceId.webp"),
          fit: BoxFit.contain,
          width: 48 * scale,
          height: 48 * scale,
        );
      case "items":
        return Image.network(
          "$urlBase/items/$identifier.webp",
          fit: BoxFit.contain,
          width: 32 * scale,
          height: 32 * scale,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
