import 'package:environment_sensors/environment_sensors.dart'; // Ensure in pubspec

class AmbientLightReader {
  static final environmentSensors = EnvironmentSensors();

  static void listenForDarkness(Function(bool isDark) onLightChange) {
    environmentSensors.light.listen((lux) {
      if (lux < 10) { // Less than 10 Lux is very dark (e.g., reading in bed with lights off)
        onLightChange(true);
      } else {
        onLightChange(false);
      }
    });
  }
}