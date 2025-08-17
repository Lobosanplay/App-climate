# Climate App 🌤️

Una aplicación meteorológica desarrollada con Flutter que muestra condiciones climáticas actuales y pronósticos. Actualmente enfocada en Bogotá como proyecto de práctica, con capacidad para expandirse a ubicaciones globales.

## 📱 Plataformas compatibles
- Android

## 🛠️ Configuración

### Requisitos previos
- Flutter SDK (versión 3.0 o superior)
- Dart SDK
- Dispositivo/emulador Android/iOS

### Instalación
1. Clonar el repositorio:
```bash
git clone https://github.com/tu-usuario/app-climate.git
```

2. Navegar al directorio del proyecto:
```bash
cd app-climate
```

3. Instalar dependencias:
```bash
flutter pub get
```

## Ejecución
- Para ejecutar en modo desarrollo:
```bash
flutter run
```

- Para construir APK release:
```bash
flutter build apk --release
```

## 🏗️ Estructura del proyecto
```
lib/
├── main.dart                # Punto de entrada
├── app/                     # Configuración inicial
│   └── app.dart             # Widget principal de la aplicación
└── features/
    └── weather/
        ├── presentation/
        │   ├── pages/       # Pantallas
        │   │   └── home_page.dart
        │   └── widgets/    # Componentes UI
        │       ├── current_weather.dart
        │       ├── hourly_forecast.dart
        │       ├── location_header.dart
        │       ├── three_day_forecast.dart
        │       └── weather_display.dart
        └── providers/       # Lógica de estado
            └── weather_provider.dart
```
## 🌐 API Utilizada
La aplicación consume datos de [WeatherAPI.com](https://www.weatherapi.com), proporcionando:

- Clima actual

- Pronóstico por horas

- Pronóstico de 3 días

Parámetro configurable: La ubicación puede modificarse cambiando el parámetro **location** en el provider.

## 📸 Capturas de pantalla
Vista principal

![AppClimate](public/image-1.png)

## 🚀 Características
- Muestra temperatura actual y sensación térmica

- Pronóstico horario interactivo

- Pronóstico de 3 días

- Diseño adaptable

## 📌 Próximas mejoras
- Búsqueda por ciudad

- Gradientes dinámicos según condiciones climáticas

- Soporte para múltiples ubicaciones

- Notificaciones de clima severo

## 📄 Licencia
Este proyecto está bajo licencia MIT. Ver [LICENSE](LICENSE) para más detalles.
