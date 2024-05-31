import 'package:miscelaneos/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    'it.matbuompy.miscelaneos.fetch-background-pokemon';
const fetchBackgroundPeriodicTaskKey =
    'it.matbuompy.miscelaneos.fetch-background-periodic-pokemon';

// Mandatory if the App is obfuscated or using Flutter 3.1+
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        print(fetchBackgroundTaskKey);
        break;
      case fetchBackgroundPeriodicTaskKey:
        await loadNextPokemon();
        print(fetchBackgroundPeriodicTaskKey);
        break;
      case Workmanager.iOSBackgroundTask:
        print(Workmanager.iOSBackgroundTask);
        break;
    }
    return true;
  });
}

Future<void> loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonsRepository = PokemonsRepositoryImpl();
  final lastPokemonId = await localDbRepository.pokemonCount() + 1;
  try {
    final (pokemon, error) =
        await pokemonsRepository.getPokemon(lastPokemonId.toString());
    if (pokemon == null) throw error;
    await localDbRepository.insertPokemon(pokemon);
  } catch (e) {
    print(e);
  }
}
