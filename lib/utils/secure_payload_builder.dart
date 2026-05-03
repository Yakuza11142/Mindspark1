class SecurePayloadBuilder {
  static Map<String, dynamic> build(Map<String, dynamic> data, String hwId) {
    data['signed_hw_id'] = hwId;
    data['timestamp'] = DateTime.now().toIso8601String();
    return data;
  }
}