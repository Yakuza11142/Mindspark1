import 'package:provider/provider.dart';
import 'services/currency_manager.dart';
import 'services/ad_manager.dart';
// Helper to clean up main.dart
List<SingleChildCloneableWidget> get globalProviders => [
  ChangeNotifierProvider(create: (_) => CurrencyManager()),
  Provider(create: (_) => AdManager()),
];