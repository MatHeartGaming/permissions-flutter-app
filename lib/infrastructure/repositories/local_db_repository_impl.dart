import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasources/isar_local_db_datasource.dart';

class LocalDbRepositoryImpl implements LocalDbRepository {
  final LocalDbDatasource _db;

  LocalDbRepositoryImpl([LocalDbDatasource? datasource])
      : _db = datasource ?? IsarLocalDbDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    _db.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _db.loadPokemons();
  }

  @override
  Future<int> pokemonCount() async {
    return _db.pokemonCount();
  }
}
