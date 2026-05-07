class LowStorageWarning {
  static bool hasEnoughSpace(int currentFreeSpaceMb) {
    return currentFreeSpaceMb > 500; // Require 500MB free
  }
}