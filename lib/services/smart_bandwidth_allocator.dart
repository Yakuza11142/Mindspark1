class SmartBandwidthAllocator {
  static String getVideoQuality(int pingMs) {
    if (pingMs < 100) return "4K_UHD"; // 5G / Fiber
    if (pingMs < 300) return "1080p_HD"; // 4G
    if (pingMs < 800) return "480p_SD"; // 3G
    return "TEXT_ONLY"; // Edge / 2G
  }
}