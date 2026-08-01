import 'dart:convert';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

enum PricingTier {
  tier1HighIncome(9.99),
  tier2MediumIncome(5.99),
  tier3EmergingMarket(2.99);

  final double priceUsd;
  const PricingTier(this.priceUsd);
}

class RegionalPricingConfig {
  final String tier;
  final String currencyCode;

  const RegionalPricingConfig({
    required this.tier,
    required this.currencyCode,
  });
}

class PppPricingEngine {
  static Map<String, RegionalPricingConfig> _dynamicCountryMatrix = {};
  static Map<String, double> _liveExchangeRates = {"USD": 1.0};
  static bool _isInitialized = false;

  static const Set<String> _zeroDecimalCurrencies = {
    'JPY', 'KRW', 'CLP', 'VND', 'ISK', 'UGX', 'PYG', 'RWF', 'BIF', 'DJF', 'GNF', 'KMF', 'XAF', 'XOF', 'XPF'
  };

  static void initialize({
    required String jsonConfigPayload, 
    required Map<String, double> exchangeRates,
  }) {
    try {
      final dynamic decoded = jsonDecode(jsonConfigPayload);
      if (decoded is Map) {
        final Map<String, dynamic> typedSource = Map<String, dynamic>.from(decoded);
        
        _dynamicCountryMatrix = typedSource.map((key, value) {
          final String cleanedKey = key.trim().toUpperCase();
          if (value is Map) {
            return MapEntry(
              cleanedKey,
              RegionalPricingConfig(
                tier: value['tier'].toString().trim().toUpperCase(),
                currencyCode: value['currency'].toString().trim().toUpperCase(),
              ),
            );
          }
          return MapEntry(
            cleanedKey,
            RegionalPricingConfig(tier: value.toString().trim().toUpperCase(), currencyCode: "USD"),
          );
        });

        _liveExchangeRates = exchangeRates.map((key, value) => MapEntry(key.toUpperCase(), value.toDouble()));
        _liveExchangeRates["USD"] = 1.0; 
        
        _isInitialized = true;
        developer.log("📊 PPP Pricing Engine: Localized matrix populated safely. Tracked regions: ${_dynamicCountryMatrix.length}");
      }
    } catch (e, stack) {
      developer.log("❌ PPP Pricing Engine: Initialization data parse loop fault", error: e, stackTrace: stack);
    }
  }

  static String getLocalizedPriceString(String isoCode) {
    final String standardizedKey = isoCode.trim().toUpperCase();
    
    if (!_isInitialized) {
      developer.log("⚠️ PPP Pricing Engine: Uninitialized context lookup. Falling back to default USD formatting configuration.");
      return NumberFormat.simpleCurrency(name: 'USD').format(PricingTier.tier1HighIncome.priceUsd);
    }

    final RegionalPricingConfig? config = _dynamicCountryMatrix[standardizedKey];
    final double baseUsdPrice = _resolveBaseUsdPrice(config?.tier);
    final String targetCurrency = config?.currencyCode ?? "USD";

    final double exchangeRate = _liveExchangeRates[targetCurrency] ?? 1.0;
    final double rawLocalizedPrice = baseUsdPrice * exchangeRate;
    
    final double roundedPrice = _applyPsychologicalRounding(rawLocalizedPrice, targetCurrency);

    try {
      final NumberFormat localFormatter = NumberFormat.simpleCurrency(name: targetCurrency);
      return localFormatter.format(roundedPrice);
    } catch (e) {
      developer.log("Formatting mismatch encountered for currency indicator: $targetCurrency. Falling back to explicit text tags.");
      return "$roundedPrice $targetCurrency";
    }
  }

  static double _resolveBaseUsdPrice(String? tierLabel) {
    if (tierLabel == "TIER_1" || tierLabel == "HIGH_INCOME") {
      return PricingTier.tier1HighIncome.priceUsd;
    }
    if (tierLabel == "TIER_2" || tierLabel == "MEDIUM_INCOME") {
      return PricingTier.tier2MediumIncome.priceUsd;
    }
    if (tierLabel == "TIER_3" || tierLabel == "EMERGING_MARKET") {
      return PricingTier.tier3EmergingMarket.priceUsd;
    }
    return PricingTier.tier1HighIncome.priceUsd; 
  }

  /// Psychological marketing rounding normalization engine
  static double _applyPsychologicalRounding(double rawPrice, String currency) {
    final String upperCurrency = currency.toUpperCase();
    final bool isZeroDecimal = _zeroDecimalCurrencies.contains(upperCurrency);
    
    if (rawPrice <= 0 || rawPrice.isNaN || rawPrice.isInfinite) return 0.00;

    if (upperCurrency == "USD" || upperCurrency == "EUR" || upperCurrency == "GBP") {
      final double roundedToCents = (rawPrice * 100).roundToDouble() / 100;
      final double fraction = roundedToCents - roundedToCents.truncateToDouble();
      
      if (fraction >= 0.50) {
        return roundedToCents.truncateToDouble() + 0.99;
      } else {
        final double standardLowerBound = roundedToCents.truncateToDouble() - 1.0;
        return (standardLowerBound < 0 ? 0.0 : standardLowerBound) + 0.99;
      }
    }
    
    if (rawPrice > 100) {
      final int baseInteger = rawPrice.round();
      
      if (isZeroDecimal) {
        if (baseInteger < 1000) {
          final int remainder = baseInteger % 100;
          return (baseInteger - remainder + 95).toDouble(); 
        }
        
        final int remainder = baseInteger % 1000;
        if (remainder < 500) {
          return (baseInteger - remainder + 450).toDouble(); 
        } else {
          return (baseInteger - remainder + 950).toDouble(); 
        }
      }
      
      final int remainder = baseInteger % 100;
      if (remainder < 50) {
        return (baseInteger - remainder + 49).toDouble(); 
      } else {
        return (baseInteger - remainder + 99).toDouble(); 
      }
    }
    
    if (isZeroDecimal) return rawPrice.roundToDouble();
    
    final int centsConversion = (rawPrice * 100).round();
    return centsConversion / 100.0;
  }
}
