class VersionCheck {
  static const currentVersion = 100;
  static bool isOutdated(int minVersion) => currentVersion < minVersion;
}