import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/resource_icon.dart';

class AbilityResourceScreen extends ResourceScreen<Ability> {
  const AbilityResourceScreen({
    super.key,
    required super.resourceType,
    required super.resourceId,
    required super.title,
    required super.fromJsonFactory,
  });

  @override
  ConsumerState<AbilityResourceScreen> createState() =>
      _AbilityResourceScreenState();
}

class _AbilityResourceScreenState extends ConsumerState<AbilityResourceScreen> {
  @override
  Widget build(BuildContext context) {
    final abilityPokemons = ref.watch(
      abilityPokemonsProvider(widget.resourceId),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: abilityPokemons.when(
        data: (pokemons) {
          if (pokemons.data.isEmpty) {
            return const Center(child: Text('没有相关的宝可梦'));
          }

          return ListView.builder(
            itemCount: pokemons.data.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons.data[index];
              return ListTile(
                title: Text(pokemon.name),
                subtitle: Text('ID: ${pokemon.id}'),
                leading: ResourceIcon(
                  resourceId: pokemon.id,
                  resourceType: 'pokemon-species',
                  identifier: pokemon.name,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}
