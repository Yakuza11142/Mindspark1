class LagosNetworkTimeout {
  // Instead of a standard 5-second timeout, we give Nigerian networks 15 seconds.
  static const int connectTimeoutMs = 15000;
  static const int receiveTimeoutMs = 20000;
}