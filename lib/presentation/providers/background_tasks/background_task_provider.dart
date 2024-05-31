import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

final backgroundPokemonFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchBackgroundPeriodicTaskKey);
});

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  Future<void> checkCurrentStatus() async {
    state = await SharedPrefsPlugin.getBool(processKeyName) ?? false;
  }

  void toggleProcess() {
    if (state == true) {
      deactivateProcess();
    } else {
      activateTask();
    }
  }

  Future<void> activateTask() async {
    // La primera vez es inmediato
    await Workmanager().registerPeriodicTask(
      processKeyName, processKeyName,
      frequency: const Duration(minutes: 15), //! 15 min es el minimo!
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processKeyName,
    );

    await SharedPrefsPlugin.setBool(processKeyName, true);
    state = true;
  }

  Future<void> deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName).then(
      (value) {
        SharedPrefsPlugin.setBool(processKeyName, false);
        state = false;
      },
    );
  }
}
