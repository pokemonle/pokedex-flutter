import 'package:flutter/material.dart';

class ResourceIcon extends StatelessWidget {
  final int resourceId;
  final String resourceType;
  final String identifier;

  final String urlBase = "https://image.pokemonle.incubator4.com";

  const ResourceIcon({
    super.key,

    required this.resourceId,
    required this.resourceType,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    switch (resourceType) {
      case "pokemon-species":
        return Image.network("$urlBase/pokemon/$resourceId.webp");
      case "items":
        return Image.network("$urlBase/items/$identifier.webp");
      default:
        return const SizedBox.shrink();
    }
  }
}
