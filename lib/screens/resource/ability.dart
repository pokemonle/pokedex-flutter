import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/navigation.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/screens/resource/pokemon.dart';
import 'package:pokedex/widgets/resource.dart';
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
  late final flavorTextNotifier = flavorTextProvider(
    resource: widget.resourceType,
  );

  @override
  Widget build(BuildContext context) {
    final abilityPokemons = ref.watch(
      abilityPokemonsProvider(widget.resourceId),
    );

    final flavorText = ref.watch(flavorTextNotifier(widget.resourceId));

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          flavorText.when(
            data:
                (text) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        text.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          Expanded(
            child: abilityPokemons.when(
              data: (pokemons) {
                if (pokemons.data.isEmpty) {
                  return const Center(child: Text('没有相关的宝可梦'));
                }

                return ListView.builder(
                  itemCount: pokemons.data.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons.data[index];
                    return ResourceWidget(
                      title: pokemon.name,
                      icon: ResourceIcon(
                        resourceId: pokemon.id,
                        resourceType: 'pokemon-species',
                        identifier: pokemon.name,
                      ),
                      subtitle: 'ID: ${pokemon.id}',
                      onTap:
                          () => navigateToResource<PokemonSpecie>(
                            context,
                            'pokemon-species',
                            pokemon.id,
                            pokemon.name,
                            PokemonSpecie.fromJson,
                            (
                              context,
                              resourceType,
                              resourceId,
                              title,
                              fromJsonFactory,
                            ) => PokemonResourceScreen<PokemonSpecie>(
                              resourceType: resourceType,
                              resourceId: resourceId,
                              title: title,
                              fromJsonFactory: fromJsonFactory,
                            ),
                          ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('加载失败: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
