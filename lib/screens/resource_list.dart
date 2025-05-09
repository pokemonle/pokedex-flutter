import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/widgets/pagination_controls.dart';
import 'package:pokedex/widgets/translation.dart';

class ResourceListScreen<T extends Resource> extends ConsumerStatefulWidget {
  final String resourceType;
  final String title;
  final T Function(Map<String, dynamic> json) fromJsonFactory;

  const ResourceListScreen({
    super.key,
    required this.resourceType,
    required this.title,
    required this.fromJsonFactory,
  });

  @override
  ConsumerState<ResourceListScreen<T>> createState() =>
      _ResourceListScreenState<T>();
}

class _ResourceListScreenState<T extends Resource>
    extends ConsumerState<ResourceListScreen<T>> {
  final int _perPage = 15; // Or your desired items per page
  late final resourceListNotifier = resourceListProvider<T>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  String _padId(int id) {
    return id.toString().padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);
    final asyncResourceList = ref.watch(
      resourceListNotifier((page: currentPage, perPage: _perPage)),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          asyncResourceList.when(
            data: (paginationData) {
              if (paginationData.data.isEmpty && paginationData.page > 1) {
                // API might return empty if page is out of bounds, try to go to last known good page
                // Or handle as "no more items"
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    ref.read(currentPageProvider.notifier).state =
                        paginationData.totalPages > 0
                            ? paginationData.totalPages
                            : 1;
                  }
                });
                return const Center(
                  child: Text("No more items or invalid page. Adjusting..."),
                );
              }
              if (paginationData.data.isEmpty && paginationData.page == 1) {
                return const Center(child: Text("No items found."));
              }

              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PaginationControls(
                        currentPage: paginationData.page,
                        totalPages: paginationData.totalPages,
                        onPageChange: (newPage) {
                          ref.read(currentPageProvider.notifier).state =
                              newPage;
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: paginationData.data.length,
                        itemBuilder: (context, index) {
                          final item = paginationData.data[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    '#${_padId(item.id)} - ',
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  TranslationWidget(
                                    namespace:
                                        widget.resourceType == "pokemon"
                                            ? "pokemon_species"
                                            : widget.resourceType,
                                    textKey: item.identifier,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ResourceScreen<T>(
                                          resourceType: widget.resourceType,
                                          resourceId: item.id,
                                          title: widget.title,
                                          fromJsonFactory:
                                              widget.fromJsonFactory,
                                        ),
                                  ),
                                );

                                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceDetailScreen(resource: item)));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading:
                () => const Center(child: CircularProgressIndicator.adaptive()),
            error:
                (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      ElevatedButton(
                        onPressed: () {
                          // Don't directly call setState. Instead, invalidate to force a refetch.
                          ref.invalidate(
                            resourceListNotifier((
                              page: currentPage,
                              perPage: _perPage,
                            )),
                          );
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
