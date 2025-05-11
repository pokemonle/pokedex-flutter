import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/client.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/translation.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef ResourceFetcher<T> = Future<T> Function(int id);
typedef ResourceListFetcher<T> =
    Future<PaginationResource<T>> Function(int page, int perPage);

final resourceProvider = <T extends Resource>({
  required String resource,
  required FromJson<T> fromJson,
}) {
  return FutureProvider.autoDispose.family<T, int>((ref, id) async {
    final client = ApiClient();
    final languageId = ref.watch(currentLanguageProvider);
    final data = await client.get(
      '$resource/$id',
      params: {"lang": languageId.toString()},
    );
    return fromJson(data);
  });
};

final resourceListProvider = <T extends Resource>({
  required String resource,
  required FromJson<T> fromJson,
}) {
  return FutureProvider.autoDispose
      .family<PaginationResource<T>, ({int page, int perPage})>((
        ref,
        params,
      ) async {
        final client = ApiClient();
        final languageId = ref.watch(currentLanguageProvider);
        final data = await client.get(
          resource,
          params: {
            'page': params.page.toString(),
            'per_page': params.perPage.toString(),
            'lang': languageId.toString(),
          },
        );

        return PaginationResource<T>.fromJson(
          data,
          (json) => fromJson(json as Map<String, dynamic>),
        );
      });
};

// 创建一个固定的 provider 来存储当前页面的状态
final currentPageProvider = StateProvider.autoDispose<int>((ref) => 1);
