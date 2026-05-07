class PortfolioExporter {
  static String generatePortfolioLink(String userId) {
    // Generates a public URL like mindspark.app/p/musa123
    return "https://mindspark.app/portfolio/$userId";
  }
}