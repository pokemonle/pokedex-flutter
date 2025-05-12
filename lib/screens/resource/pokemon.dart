import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/navigation.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/widgets/resource.dart';

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
                  padding: const EdgeInsets.all(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FadeInImage(
                      placeholder: const AssetImage(
                        "assets/pokemon_placeholder.png",
                      ),
                      image: NetworkImage(
                        "https://image.pokemonle.incubator4.com/pokemon/${data.id}.webp",
                      ),
                      fit: BoxFit.contain,
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
                      _EvolutionTab(data: data),
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

class _BasicInfoTab extends StatelessWidget {
  final PokemonSpecie data;

  const _BasicInfoTab({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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

class _EvolutionTab extends StatelessWidget {
  final PokemonSpecie data;

  const _EvolutionTab({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('1')),
            title: Text('进化前形态'),
            subtitle: Text('进化条件...'),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('2')),
            title: Text('当前形态'),
            subtitle: Text('进化条件...'),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('3')),
            title: Text('进化后形态'),
            subtitle: Text('进化条件...'),
          ),
        ),
      ],
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
