import 'package:flutter/material.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/api/models/pokemon_specie.dart';
import 'package:pokedex/screens/resource/ability.dart';
import 'package:pokedex/screens/resource/pokemon.dart';
import 'package:pokedex/screens/resource_list.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/widgets/resource.dart';

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
                  AppLocalizations.of(context)!.abilities,
                  Ability.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      AbilityResourceScreen(
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
                  AppLocalizations.of(context)!.items,
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
                  'pokemon-species',
                  AppLocalizations.of(context)!.pokemon,
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
                  AppLocalizations.of(context)!.moves,
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
    return ResourceWidget(
      icon: icon,
      title: title,
      onTap: onTap,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      rightIcon: true,
    );
  }
}
