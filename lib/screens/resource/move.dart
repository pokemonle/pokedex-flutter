import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/type_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoveResourceScreen extends ResourceScreen<Move> {
  const MoveResourceScreen({
    super.key,
    required super.resourceType,
    required super.resourceId,
    required super.title,
    required super.fromJsonFactory,
  });

  @override
  ConsumerState<MoveResourceScreen> createState() => _MoveResourceScreenState();
}

class _MoveResourceScreenState extends ConsumerState<MoveResourceScreen> {
  late final resourceNotifier = resourceProvider<Move>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  late final flavorTextNotifier = flavorTextProvider(
    resource: widget.resourceType,
  );

  @override
  Widget build(BuildContext context) {
    final move = ref.watch(resourceNotifier(widget.resourceId));
    final flavorText = ref.watch(flavorTextNotifier(widget.resourceId));

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: move.when(
        data:
            (move) => SingleChildScrollView(
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
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => const SizedBox.shrink(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        InfoRow(
                          label: AppLocalizations.of(context)!.power,
                          value: move.power?.toString() ?? '-',
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.pp,
                          value:
                              move.pp != null
                                  ? '${move.pp} / ${(move.pp! * 1.6).toInt()}'
                                  : '-',
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.accuracy,
                          value: move.accuracy?.toString() ?? '-',
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.priority,
                          value: move.priority.toString(),
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.generation,
                          value: move.generationId.toString(),
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.type,
                          valueWidget:
                              move.typeId != null
                                  ? TypeIcon(id: move.typeId!)
                                  : null,
                          value: move.typeId != null ? null : '-',
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.damageClass,
                          value: AppLocalizations.of(context)!.damageClassId(
                            switch (move.damageClassId) {
                              1 => 'status',
                              2 => 'physical',
                              3 => 'special',
                              _ => 'other',
                            },
                          ),
                        ),
                        InfoRow(
                          label: AppLocalizations.of(context)!.target,
                          value: move.targetId.toString(),
                        ),
                        if (move.effectChance != null)
                          InfoRow(
                            label: AppLocalizations.of(context)!.effectChance,
                            value: '${move.effectChance}%',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;

  const InfoRow({super.key, required this.label, this.value, this.valueWidget});

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
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: valueWidget ?? Text(value ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
