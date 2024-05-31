import 'package:isar/isar.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDatasource implements LocalDbDatasource {
  late Future<Isar> _db;

  IsarLocalDbDatasource() {
    _db = _openDB();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema], directory: dir.path);
    }

    return Isar.getInstance()!;
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final isar = await _db;
    isar.writeTxnSync(
      () => isar.pokemons.putSync(pokemon),
    );
    print('Inserted Pokemon: ${pokemon.name}');
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isar = await _db;
    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await _db;
    return isar.pokemons.count();
  }
}
