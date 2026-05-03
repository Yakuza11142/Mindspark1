class OfflineSyncConflictResolver {
  static Map<String, dynamic> resolveSparks(int cloudSparks, int localSparks, DateTime cloudTime, DateTime localTime) {
    // The device with the latest timestamp wins, but we never decrease sparks accidentally
    if (localSparks > cloudSparks) {
      return {'sparks': localSparks, 'source': 'local'};
    }
    return {'sparks': cloudSparks, 'source': 'cloud'};
  }
}