import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/navigation.dart';
import 'package:pokedex/providers/resource.dart';
import 'package:pokedex/widgets/pagination_controls.dart';
import 'package:pokedex/widgets/resource.dart';
import 'package:pokedex/widgets/resource_icon.dart';
import 'dart:async';

class ResourceListScreen<T extends LanguageResource>
    extends ConsumerStatefulWidget {
  final String resourceType;
  final String title;
  final T Function(Map<String, dynamic> json) fromJsonFactory;
  final ResourceScreenBuilder<T> resourceScreenBuilder;

  const ResourceListScreen({
    super.key,
    required this.resourceType,
    required this.title,
    required this.fromJsonFactory,
    required this.resourceScreenBuilder,
  });

  @override
  ConsumerState<ResourceListScreen<T>> createState() =>
      _ResourceListScreenState<T>();
}

class _ResourceListScreenState<T extends LanguageResource>
    extends ConsumerState<ResourceListScreen<T>> {
  int _perPage = 24;
  bool _isGridView = false; // 默认列表视图
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();
  late final resourceListNotifier = resourceListProvider<T>(
    resource: widget.resourceType,
    fromJson: widget.fromJsonFactory,
  );

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String _padId(int id) {
    return id.toString().padLeft(4, '0');
  }

  void _handlePerPageChange(int newPerPage) {
    setState(() {
      _perPage = newPerPage;
    });
    // 重置到第一页
    ref.read(currentPageProvider.notifier).state = 1;
  }

  void _toggleViewMode() {
    // 只在支持图片的资源类型时允许切换到网格模式
    if (widget.resourceType == "pokemon_species" ||
        widget.resourceType == "items") {
      setState(() {
        _isGridView = !_isGridView;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = query;
      // 重置到第一页
      ref.read(currentPageProvider.notifier).state = 1;
    });
  }

  // 计算网格列数
  int _calculateGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 12;
    if (width > 900) return 8;
    if (width > 600) return 6;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final asyncResourceList = ref.watch(
      resourceListNotifier((
        page: currentPage,
        perPage: _perPage,
        query: searchQuery,
      )),
    );

    // 检查是否支持网格视图
    final bool supportsGridView =
        widget.resourceType == "pokemon" || widget.resourceType == "items";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (supportsGridView)
            IconButton(
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
              onPressed: _toggleViewMode,
              tooltip: _isGridView ? '列表视图' : '网格视图',
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
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
                        perPage: _perPage,
                        onPageChange: (newPage) {
                          ref.read(currentPageProvider.notifier).state =
                              newPage;
                        },
                        onPerPageChange: _handlePerPageChange,
                      ),
                    ),
                    Expanded(
                      child:
                          _isGridView && supportsGridView
                              ? GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          _calculateGridCrossAxisCount(context),
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                    ),
                                itemCount: paginationData.data.length,
                                itemBuilder: (context, index) {
                                  final item = paginationData.data[index];
                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await Future.delayed(
                                            const Duration(milliseconds: 150),
                                          );
                                          if (context.mounted) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => widget
                                                        .resourceScreenBuilder(
                                                          context,
                                                          widget.resourceType,
                                                          item.id,
                                                          item.name,
                                                          widget
                                                              .fromJsonFactory,
                                                        ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Center(
                                          child: ResourceIcon(
                                            resourceId: item.id,
                                            resourceType: widget.resourceType,
                                            identifier: item.identifier,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                              : ListView.builder(
                                itemCount: paginationData.data.length,
                                itemBuilder: (context, index) {
                                  final colorScheme =
                                      Theme.of(context).colorScheme;
                                  final item = paginationData.data[index];

                                  return ResourceWidget(
                                    icon: ResourceIcon(
                                      resourceId: item.id,
                                      resourceType: widget.resourceType,
                                      identifier: item.identifier,
                                    ),
                                    title: item.name,
                                    subtitle: 'ID: ${item.id}',
                                    onTap:
                                        () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => widget
                                                      .resourceScreenBuilder(
                                                        context,
                                                        widget.resourceType,
                                                        item.id,
                                                        item.name,
                                                        widget.fromJsonFactory,
                                                      ),
                                            ),
                                          ),
                                        },
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
                              query: searchQuery,
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
