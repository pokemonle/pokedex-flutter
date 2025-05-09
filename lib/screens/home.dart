import 'package:flutter/material.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/screens/resource_list.dart';

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
      appBar: AppBar(title: const Text('Home - Pokedex Resources')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _ResourceNavigationCard(
            title: 'Abilities',
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
            title: 'Items',
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
            title: 'Pokemon', // Example
            icon: Icons.catching_pokemon_outlined,
            onTap:
                () => _navigateToResourceList<Pokemon>(
                  context,
                  'pokemon', // Ensure your API client handles 'pokemon'
                  'Pokemon',
                  Pokemon.fromJson,
                ),
          ),
          // Add more for Berries, Generations, etc.
          // _ResourceNavigationCard(
          //   title: 'Berries',
          //   icon: Icons.apple, // Choose appropriate icon
          //   onTap: () => _navigateToResourceList<Berry>(
          //     context,
          //     'berries',
          //     'Berries',
          //     Berry.fromJson, // Assuming Berry model and fromJson exist
          //   ),
          // ),
          // _ResourceNavigationCard(
          //   title: 'Generations',
          //   icon: Icons.filter_vintage_outlined,
          //   onTap: () => _navigateToResourceList<Generation>(
          //     context,
          //     'generations',
          //     'Generations',
          //     Generation.fromJson, // Assuming Generation model and fromJson exist
          //   ),
          // ),
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
        leading: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
