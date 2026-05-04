class BatteryThermalThrottling {
  static bool shouldDisableAR(int batteryLevel, bool isCharging) {
    // AR + Charging causes extreme heat on cheap phones.
    if (isCharging && batteryLevel < 20) {
      print("🌡️ Thermal Risk: Disabling Holo-Deck to prevent device overheating.");
      return true;
    }
    return false;
  }
}