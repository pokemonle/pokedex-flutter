import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/navigation.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/widgets/resource.dart';
import 'package:pokedex/widgets/resource_icon.dart';

class PokemonResourceScreen<T extends PokemonSpecie> extends ResourceScreen<T> {
  const PokemonResourceScreen({
    super.key,
    required super.resourceType,
    required super.resourceId,
    required super.title,
    required super.fromJsonFactory,
  });

  @override
  ConsumerState<PokemonResourceScreen<T>> createState() =>
      PokemonResourceScreenState<T>();
}

class PokemonResourceScreenState<T extends PokemonSpecie>
    extends ConsumerState<PokemonResourceScreen<T>>
    with SingleTickerProviderStateMixin {
  late final resourceNotifier = resourceProvider<T>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncResource = ref.watch(resourceNotifier(widget.resourceId));

    return Scaffold(
      appBar: AppBar(
        title: asyncResource.when(
          data: (data) => Text(data.name),
          error: (error, stackTrace) => Text('Error: $error'),
          loading:
              () => const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      body: asyncResource.when(
        data:
            (data) => Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(4),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ResourceIcon(
                      resourceId: data.id,
                      resourceType: 'pokemon-species',
                      identifier: data.name,
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.basicInfo),
                    Tab(text: AppLocalizations.of(context)!.abilities),
                    Tab(text: AppLocalizations.of(context)!.evolution),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _BasicInfoTab(data: data),
                      _AbilitiesTab(data: data),
                      EvolutionTab(data: data),
                    ],
                  ),
                ),
              ],
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

class _BasicInfoTab extends ConsumerWidget {
  final PokemonSpecie data;
  final flavorTextNotifier = flavorTextProvider(resource: 'pokemon-species');

  _BasicInfoTab({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorText = ref.watch(flavorTextNotifier(data.id));

    return SingleChildScrollView(
      child: Column(
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
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InfoRow(
                  label: AppLocalizations.of(context)!.pokedexId,
                  value: "#${data.id}",
                ),
                InfoRow(label: "Color", value: data.colorId.toString()),
                InfoRow(
                  label: AppLocalizations.of(context)!.formsSwitchable,
                  value: data.formsSwitchable.toString(),
                ),
                InfoRow(
                  label: AppLocalizations.of(context)!.generation,
                  value: data.generationId.toString(),
                ),
                InfoRow(
                  label: AppLocalizations.of(context)!.growthRate,
                  value: data.growthRateId.toString(),
                ),
                InfoRow(
                  label: "Has Gender Differences",
                  value: data.hasGenderDifferences.toString(),
                ),
                InfoRow(
                  label: AppLocalizations.of(context)!.hatchCounter,
                  value: data.hatchCounter.toString(),
                ),
                InfoRow(
                  label: AppLocalizations.of(context)!.conquestOrder,
                  value: data.conquestOrder.toString(),
                ),
                InfoRow(
                  label: AppLocalizations.of(context)!.formsSwitchable,
                  value: data.formsSwitchable.toString(),
                ),
                InfoRow(
                  label: "Evolution Chain",
                  value: data.evolutionChainId.toString(),
                ),
                InfoRow(label: "Shape", value: data.shapeId.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AbilitiesTab extends ConsumerWidget {
  final PokemonSpecie data;

  const _AbilitiesTab({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilitiesAsync = ref.watch(pokemonAbilitiesProvider(data.id));

    return abilitiesAsync.when(
      data: (abilitiesResponse) {
        if (abilitiesResponse.data.isEmpty) {
          return const Center(child: Text('没有可用的特性数据'));
        }

        final sortedAbilities = List<AbilityWithSlot>.from(
          abilitiesResponse.data,
        )..sort((a, b) => a.slot.compareTo(b.slot));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sortedAbilities.length,
          itemBuilder: (context, index) {
            final ability = sortedAbilities[index];
            return ResourceWidget(
              title: ability.name,
              subtitle:
                  "${AppLocalizations.of(context)!.generation}: ${ability.generationId}",
              watermark: ability.isHidden ? "隐藏" : null,
              onTap:
                  () => navigateToResource<Ability>(
                    context,
                    'abilities',
                    ability.id,
                    ability.name,
                    Ability.fromJson,
                    (
                      context,
                      resourceType,
                      resourceId,
                      title,
                      fromJsonFactory,
                    ) => ResourceScreen(
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
      error: (error, stackTrace) => Center(child: Text('加载特性失败: $error')),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class EvolutionTab extends ConsumerStatefulWidget {
  final PokemonSpecie data;

  const EvolutionTab({super.key, required this.data});

  @override
  ConsumerState<EvolutionTab> createState() => _EvolutionTabState();
}

class _EvolutionTabState extends ConsumerState<EvolutionTab> {
  @override
  Widget build(BuildContext context) {
    final evolutionChainAsync = ref.watch(
      evolutionChainPokemonSpecieProvider(widget.data.evolutionChainId),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: evolutionChainAsync.when(
        data:
            (data) =>
                data.data.map((e) {
                  final isCurrentPokemon = e.id == widget.data.id;
                  return ResourceWidget(
                    title: e.name,
                    icon: ResourceIcon(
                      resourceId: e.id,
                      resourceType: 'pokemon-species',
                      identifier: e.name,
                    ),
                    isSelected: isCurrentPokemon,
                    onTap:
                        () => navigateToResource<PokemonSpecie>(
                          context,
                          'pokemon-species',
                          e.id,
                          e.name,
                          PokemonSpecie.fromJson,
                          (
                            context,
                            resourceType,
                            resourceId,
                            title,
                            fromJsonFactory,
                          ) => PokemonResourceScreen(
                            resourceType: resourceType,
                            resourceId: resourceId,
                            title: title,
                            fromJsonFactory: fromJsonFactory,
                          ),
                        ),
                  );
                }).toList(),
        error: (error, stackTrace) => [Text('加载进化链失败: $error')],
        loading:
            () => const [Center(child: CircularProgressIndicator.adaptive())],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
