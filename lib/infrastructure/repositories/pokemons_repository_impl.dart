import 'package:miscelaneos/domain/datasources/pokemons_datasource.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';
import 'package:miscelaneos/domain/repositories/pokemons_repository.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemon_datasource_impl.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource _datasource;

  PokemonsRepositoryImpl({PokemonsDatasource? datasource})
      : _datasource = datasource ?? PokemonDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return _datasource.getPokemon(id);
  }
}
