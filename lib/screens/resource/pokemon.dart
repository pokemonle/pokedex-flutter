import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    extends ConsumerState<PokemonResourceScreen<T>> {
  late final resourceNotifier = resourceProvider<T>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

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
            (data) => Center(
              child: Column(
                children: [
                  Image.network(
                    "https://image.pokemonle.incubator4.com/pokemon/${data.id}.webp",
                    scale: 0.4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
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
