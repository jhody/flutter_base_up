# Flutter Base

Este es el inicio de un proyecto eb flutter, contiene configuraciones iniciales como:
    
    - Logo e íconos iniciales

## Generación de iconos
En el archivo pubspec.yaml:
```dart
    dev_dependencies:
        flutter_launcher_icons: ^0.13.1
  
```
Luego ejecutar el comando para crear el archivo flutter_launcher_icons.yaml en la raiz:
```bash
    dart run flutter_launcher_icons:generate
```
Comando para sobreescribir el archivo flutter_launcher_icons.yaml en caso ya exista:
```bash
    dart run flutter_launcher_icons:generate --override
```

Luego editar el archivo flutter_launcher_icons.yaml para asignar la ruta del ícono

A continuación general los iconos para cada plataforma con el comando
```bash
    flutter pub run flutter_launcher_icons
```
## Configurar localización

En pubspec.yaml:
```dart
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0  # Asegúrate de tener la última versión
```

Crear el archivo: l10n.yaml y agregar:

```dart
    arb-dir: lib/l10n
    template-arb-file: app_es.arb
    output-localization-file: app_localizations.dart
```

luego ejecutar:

```bash
flutter gen-l10n
```
verificar que se haya crear el archivo app_localizations.dart en la ruta:
```
    .dart_tool/flutter_gen/gen_l10n/
```


