import 'package:flutter/material.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/api/models/pokemon_specie.dart';
import 'package:pokedex/screens/resource/pokemon.dart';
import 'package:pokedex/screens/resource_list.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToResourceList<T extends LanguageResource>(
    BuildContext context,
    String resourceType,
    String title,
    T Function(Map<String, dynamic>) fromJsonFactory,
    Widget Function(
      BuildContext context,
      T resource,
      String resourceType,
      String title,
      T Function(Map<String, dynamic> json) fromJsonFactory,
    )
    resourceScreenBuilder,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResourceListScreen<T>(
              resourceType: resourceType,
              title: title,
              fromJsonFactory: fromJsonFactory,
              resourceScreenBuilder: resourceScreenBuilder,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _ResourceNavigationCard(
            title: AppLocalizations.of(context)!.abilities,
            icon: Icons.star_outline,
            onTap:
                () => _navigateToResourceList<Ability>(
                  context,
                  'abilities',
                  'Abilities',
                  Ability.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      ResourceScreen<Ability>(
                        resourceType: resourceType,
                        resourceId: resource.id,
                        title: title,
                        fromJsonFactory: fromJsonFactory,
                      ),
                ),
          ),
          _ResourceNavigationCard(
            title: AppLocalizations.of(context)!.items,
            icon: Icons.backpack_outlined,
            onTap:
                () => _navigateToResourceList<Item>(
                  context,
                  'items',
                  'Items',
                  Item.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      ResourceScreen<Item>(
                        resourceType: resourceType,
                        resourceId: resource.id,
                        title: title,
                        fromJsonFactory: fromJsonFactory,
                      ),
                ),
          ),
          _ResourceNavigationCard(
            title: AppLocalizations.of(context)!.pokemon,
            icon: Icons.catching_pokemon_outlined,
            onTap:
                () => _navigateToResourceList<PokemonSpecie>(
                  context,
                  'pokemon_species',
                  'Pokemon',
                  PokemonSpecie.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      PokemonResourceScreen<PokemonSpecie>(
                        resourceType: resourceType,
                        resourceId: resource.id,
                        title: title,
                        fromJsonFactory: fromJsonFactory,
                      ),
                ),
          ),
          _ResourceNavigationCard(
            title: AppLocalizations.of(context)!.moves,
            icon: Icons.run_circle_outlined,
            onTap:
                () => _navigateToResourceList<Move>(
                  context,
                  'moves',
                  'Moves',
                  Move.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      ResourceScreen<Move>(
                        resourceType: resourceType,
                        resourceId: resource.id,
                        title: title,
                        fromJsonFactory: fromJsonFactory,
                      ),
                ),
          ),
        ],
      ),
    );
  }
}

class _ResourceNavigationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ResourceNavigationCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surface, // 使用 surface 颜色
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant, // 使用 outlineVariant 作为边框色
          width: 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency, // 透明材质保持点击效果
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: colorScheme.primary, // 统一使用 primary 颜色
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface, // 使用 onSurface 颜色
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant, // 使用 onSurfaceVariant
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
