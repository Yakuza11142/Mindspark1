class HologramMemory {
  // Stores "Secondary Files" by ID and their last known 3D position
  static final Map<String, Map<String, dynamic>> savedFiles = {};

  static void saveFile(String id, v.Vector3 position, String data) {
    savedFiles[id] = {
      "pos": position,
      "content": data,
      "timestamp": DateTime.now()
    };
  }

  static List<String> getAllSavedIds() => savedFiles.keys.toList();
}
