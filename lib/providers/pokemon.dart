import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/client.dart';
import 'package:pokedex/api/models/pagination.dart';
import 'package:pokedex/api/models/pokemon.dart';

final pokemonProvider = FutureProvider.autoDispose.family<Pokemon, String>((
  ref,
  id,
) async {
  final client = ApiClient();
  final data = await client.get('pokemons/$id');
  return Pokemon.fromJson(data);
});

final pokemonListProvider = FutureProvider.autoDispose
    .family<PaginationResource<Pokemon>, ({int page, int perPage})>((
      ref,
      params,
    ) async {
      final client = ApiClient();
      final data = await client.get(
        'pokemons',
        params: {
          'page': params.page.toString(),
          'per_page': params.perPage.toString(),
        },
      );

      // 明确传递类型化的 Map
      return PaginationResource<Pokemon>.fromJson(
        data, // 这里 data 现在已经是 Map<String, dynamic>
        (json) => Pokemon.fromJson(json as Map<String, dynamic>),
      );
    });
