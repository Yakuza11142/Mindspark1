class LocalRamCache {
  static final Map<String, dynamic> _memoryVault = {};

  static void write(String key, dynamic value) => _memoryVault[key] = value;
  
  static dynamic read(String key) => _memoryVault[key];

  static void purge() {
    _memoryVault.clear();
    print("🧹 RAM Cache Purged for optimal performance.");
  }
}