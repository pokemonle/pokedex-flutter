import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/client.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/api/models/pagination.dart';
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
      .family<PaginationResource<T>, ({int page, int perPage, String? query})>((
        ref,
        params,
      ) async {
        final client = ApiClient();
        final languageId = ref.watch(currentLanguageProvider);
        final queryParams = {
          'page': params.page.toString(),
          'per_page': params.perPage.toString(),
          'lang': languageId.toString(),
        };

        if (params.query != null && params.query!.isNotEmpty) {
          queryParams['q'] = params.query!;
        }

        final data = await client.get(resource, params: queryParams);

        return PaginationResource<T>.fromJson(
          data,
          (json) => fromJson(json as Map<String, dynamic>),
        );
      });
};

// 创建一个固定的 provider 来存储当前页面的状态
final currentPageProvider = StateProvider.autoDispose<int>((ref) => 1);

// 创建一个 provider 来获取特定 ability 相关的 Pokemon 列表
final abilityPokemonsProvider = FutureProvider.autoDispose
    .family<PaginationResource<Pokemon>, int>((ref, abilityId) async {
      final client = ApiClient();
      final languageId = ref.watch(currentLanguageProvider);
      final data = await client.get(
        'abilities/$abilityId/pokemons',
        params: {"lang": languageId.toString()},
      );

      return PaginationResource<Pokemon>.fromJson(
        data,
        (json) => Pokemon.fromJson(json as Map<String, dynamic>),
      );
    });

// 创建一个 provider 来存储搜索查询
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final pokemonAbilitiesProvider = FutureProvider.autoDispose
    .family<PaginationResource<AbilityWithSlot>, int>((ref, pokemonId) async {
      final client = ApiClient();
      final languageId = ref.watch(currentLanguageProvider);
      final data = await client.get(
        'pokemon/$pokemonId/abilities',
        params: {"lang": languageId.toString()},
      );

      return PaginationResource<AbilityWithSlot>.fromJson(
        data,
        (json) => AbilityWithSlot.fromJson(json as Map<String, dynamic>),
      );
    });

final flavorTextProvider = <T extends Resource>({required String resource}) {
  return FutureProvider.autoDispose.family<FlavorText, int>((ref, id) async {
    final client = ApiClient();
    final languageId = ref.watch(currentLanguageProvider);
    final data = await client.get(
      '$resource/$id/flavor-text/latest',
      params: {"lang": languageId.toString()},
    );
    return FlavorText.fromJson(data);
  });
};
