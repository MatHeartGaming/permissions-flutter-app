# miscelaneos

Renombrar App Package ID (Android)

```
flutter pub run change_app_package_name:main it.matbuompy.miscelaneos
```

SHA-256
```
./gradlew signingReport
```

## Pruebas IOS
```
xcrun simctl openurl booted https://pokemon-deep-linking.up.railway-app/pokemons/1/
xcrun simctl openurl booted https://pokemon-deep-linking.up.railway.app/pokemons
```

## Cambiar API Keys de Google Maps

## Generador de clases de Isar / Riverpod
```
flutter pub run build_runner build
Or
flutter pub run build_runner watch - to listen for changes and execute every time.
```