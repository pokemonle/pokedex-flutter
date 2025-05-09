import 'package:flutter/material.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/screens/resource_list.dart';
import 'package:pokedex/widgets/translation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToResourceList<T extends Resource>(
    BuildContext context,
    String resourceType,
    String title,
    T Function(Map<String, dynamic>) fromJsonFactory,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResourceListScreen<T>(
              resourceType: resourceType,
              title: title,
              fromJsonFactory: fromJsonFactory,
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
            title: t('default', 'Abilities'),
            icon: Icons.star_outline,
            onTap:
                () => _navigateToResourceList<Ability>(
                  context,
                  'abilities',
                  'Abilities',
                  Ability.fromJson,
                ),
          ),
          _ResourceNavigationCard(
            title: t('default', 'Items'),
            icon: Icons.backpack_outlined,
            onTap:
                () => _navigateToResourceList<Item>(
                  context,
                  'items',
                  'Items',
                  Item.fromJson,
                ),
          ),
          _ResourceNavigationCard(
            title: t('default', 'Pokemon'),
            icon: Icons.catching_pokemon_outlined,
            onTap:
                () => _navigateToResourceList<Pokemon>(
                  context,
                  'pokemon', // Ensure your API client handles 'pokemon'
                  'Pokemon',
                  Pokemon.fromJson,
                ),
          ),
          _ResourceNavigationCard(
            title: t('default', 'Moves'),
            icon: Icons.run_circle_outlined,
            onTap:
                () => _navigateToResourceList<Move>(
                  context,
                  'moves',
                  'Moves',
                  Move.fromJson,
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
        title: Text(
          title,
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
