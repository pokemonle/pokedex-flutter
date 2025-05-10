import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';

class ResourceScreen<T extends LanguageResource>
    extends ConsumerStatefulWidget {
  final String resourceType;
  final int resourceId;
  final String title;
  final T Function(Map<String, dynamic> json) fromJsonFactory;

  const ResourceScreen({
    super.key,
    required this.resourceType,
    required this.resourceId,
    required this.title,
    required this.fromJsonFactory,
  });

  @override
  ConsumerState<ResourceScreen<T>> createState() => _ResourceScreenState<T>();
}

class _ResourceScreenState<T extends LanguageResource>
    extends ConsumerState<ResourceScreen<T>> {
  late final resourceNotifier = resourceProvider<T>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  @override
  Widget build(BuildContext context) {
    final asyncResource = ref.watch(resourceNotifier(widget.resourceId));

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: asyncResource.when(
        data:
            (data) => Center(
              child: Text(
                JsonEncoder.withIndent("  ").convert(data.toJson().toString()),
              ),
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
