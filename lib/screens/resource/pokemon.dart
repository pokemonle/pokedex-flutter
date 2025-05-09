import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/translation.dart';

class PokemonResourceScreen<T extends Pokemon> extends ResourceScreen<T> {
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

class PokemonResourceScreenState<T extends Pokemon>
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
          data:
              (data) => TranslationWidget(
                namespace: "pokemon_species",
                textKey: data.identifier,
              ),
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
                        InfoRow(label: "Pokédex ID", value: "#${data.id}"),
                        InfoRow(
                          label: "Species ID",
                          value: "${data.speciesId}",
                        ),
                        InfoRow(
                          label: "Height",
                          value: "${data.height.toStringAsFixed(1)} m",
                        ),
                        InfoRow(
                          label: "Weight",
                          value: "${data.weight.toStringAsFixed(1)} kg",
                        ),
                        InfoRow(
                          label: "Base Experience",
                          value: "${data.baseExperience} XP",
                        ),
                        InfoRow(label: "Order", value: "#${data.order}"),
                        InfoRow(
                          label: "Default Form",
                          value: data.isDefault ? "Yes" : "No",
                        ),
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
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
