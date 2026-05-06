import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'services/currency_manager.dart';
import 'services/ad_manager.dart';
import 'engines/brain_service.dart';
import 'services/network_retry_interceptor.dart'; // Handles dropped connections

class GlobalProviders {
  static List<SingleChildWidget> build() {
    return[
      ChangeNotifierProvider(create: (_) => CurrencyManager()),
      Provider(create: (_) => AdManager()..init()),
      Provider(create: (_) => BrainService()),
    ];
  }
}