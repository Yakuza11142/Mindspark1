class OfflineTokenExchange {
  static String generateTransferQr(int amount, String senderId) {
    // Generates a one-time-use token string
    String token = "${DateTime.now().millisecondsSinceEpoch}-$senderId-$amount";
    return "SPARK_TXN_$token";
  }
}