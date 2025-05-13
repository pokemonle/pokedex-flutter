import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/item.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/resource_icon.dart';

class ItemResourceScreen extends ResourceScreen<Item> {
  const ItemResourceScreen({
    super.key,
    required super.resourceType,
    required super.resourceId,
    required super.title,
    required super.fromJsonFactory,
  });

  @override
  ConsumerState<ItemResourceScreen> createState() => _ItemResourceScreenState();
}

class _ItemResourceScreenState extends ConsumerState<ItemResourceScreen> {
  late final flavorTextNotifier = flavorTextProvider(
    resource: widget.resourceType,
  );

  late final resourceNotifier = resourceProvider<Item>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  @override
  Widget build(BuildContext context) {
    final flavorText = ref.watch(flavorTextNotifier(widget.resourceId));
    final resource = ref.watch(resourceNotifier(widget.resourceId));
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 160,
              padding: const EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 1,
                child: resource.when(
                  data:
                      (resource) => ResourceIcon(
                        resourceId: widget.resourceId,
                        resourceType: widget.resourceType,
                        identifier: resource.identifier,
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => const SizedBox.shrink(),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
