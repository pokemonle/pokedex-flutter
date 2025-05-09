import 'package:flutter/material.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/screens/resource/pokemon.dart';
import 'package:pokedex/screens/resource_list.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/translation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToResourceList<T extends Resource>(
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
            title: "Abilities",
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
            title: "Items",
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
            title: "Pokemon",
            icon: Icons.catching_pokemon_outlined,
            onTap:
                () => _navigateToResourceList<Pokemon>(
                  context,
                  'pokemon',
                  'Pokemon',
                  Pokemon.fromJson,
                  (context, resource, resourceType, title, fromJsonFactory) =>
                      PokemonResourceScreen<Pokemon>(
                        resourceType: resourceType,
                        resourceId: resource.id,
                        title: title,
                        fromJsonFactory: fromJsonFactory,
                      ),
                ),
          ),
          _ResourceNavigationCard(
            title: "Moves",
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor,
        ),
        title: TranslationWidget(
          namespace: 'default',
          textKey: title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : null,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
