import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Formats currency based on the provided [locale] or [symbol].
  /// If [locale] is null, it uses the system's current language/region.
  static String format(
    double amount, {
    String? locale, 
    String? symbol, 
    int decimalDigits = 0,
  }) {
    final formatter = NumberFormat.currency(
      // Uses provided locale, or defaults to the device's system locale
      locale: locale ?? Intl.getCurrentLocale(), 
      // If symbol is null, NumberFormat uses the locale's default (e.g., ₦ for en_NG)
      symbol: symbol, 
      decimalDigits: decimalDigits,
    );
    
    return formatter.format(amount);
  }
}
// 1. Automatic (based on user's phone settings)
String auto = CurrencyFormatter.format(5000); 

// 2. Forced Nigeria
String naira = CurrencyFormatter.format(5000, locale: 'en_NG', symbol: '₦');

// 3. Forced Japan
String yen = CurrencyFormatter.format(5000, locale: 'ja_JP', symbol: '¥');
