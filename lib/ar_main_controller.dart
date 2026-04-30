// Inside your State class
void _handleInteraction(String nodeName) {
  if (nodeName == "AH_MASTER") {
    // 0-second generation of a secondary shield
    String newId = "shield_${DateTime.now().millisecond}";
    HologramFactory.spawnInstant(arCoreController!, v.Vector3(0.5, 0, -1.0), newId);
  } else {
    // If you tap a secondary hologram, it vanishes instantly
    HologramFactory.destroyInstant(arCoreController!, nodeName);
  }
}
