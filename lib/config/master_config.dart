class MasterConfig {
  static const bool isDev = false;
  static const bool enableLogs = isDev;
  static const String serverUrl = isDev ? "http://localhost" : "https://api.mindspark.app";
}