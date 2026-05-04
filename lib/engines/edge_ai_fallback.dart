// lib/engines/offline_engine.dart

String getUniversalOfflineResponse(String query) {
  final String q = query.toLowerCase().trim();
  
  if (q.isEmpty) return "No query provided.";

  return "Cloud connection unavailable. Reconnect to restore full intelligence.";
}

bool hasOfflineCapability(String query) {
  final String q = query.toLowerCase().trim();
  if (q.isEmpty) return false;
  
  return false; 
}
