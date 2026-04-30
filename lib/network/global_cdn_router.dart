class GlobalCdnRouter {
  static String getNearestServer(String countryCode) {
    const Map<String, String> edgeServers = {
      'NG': 'lagos.edge.mindspark.app',
      'IN': 'mumbai.edge.mindspark.app',
      'US': 'virginia.edge.mindspark.app',
      'GB': 'london.edge.mindspark.app',
      'ZA': 'capetown.edge.mindspark.app'
    };
    return edgeServers[countryCode] ?? 'global.edge.mindspark.app';
  }
}