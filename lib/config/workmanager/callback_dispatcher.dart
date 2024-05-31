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
        print(fetchBackgroundTaskKey);
        break;
      case fetchBackgroundPeriodicTaskKey:
        print(fetchBackgroundPeriodicTaskKey);
        break;
      case Workmanager.iOSBackgroundTask:
        print(Workmanager.iOSBackgroundTask);
        break;
    }
    return true;
  });
}
