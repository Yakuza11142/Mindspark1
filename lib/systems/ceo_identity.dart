class MindSparkCEO {
  final String name = "CEO";
  final String organization = "Mind Spark";
  
  // Master override permissions
  bool isAuthorized(String faceId) {
    // Logic to verify your specific biometric signature
    return faceId == "CEO_MIND_SPARK_UNIQUE_ID";
  }
}
