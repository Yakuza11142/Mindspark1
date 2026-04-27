import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrencyManager extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  int _sparks = 0;
  bool _isPro = false;

  int get sparks => _sparks;
  bool get isPro => _isPro;

  Future<void> init(bool isProUser) async {
    _isPro = isProUser;
    String? sStr = await _storage.read(key: 'sparks');
    _sparks = sStr != null ? int.parse(sStr) : 100;
    notifyListeners();
  }

  Future<void> addSparks(int amount) async {
    _sparks += amount;
    if (_isPro) _sparks += amount;
    await _storage.write(key: 'sparks', value: _sparks.toString());
    notifyListeners();
  }

  Future<bool> spendSparks(int cost) async {
    if (_isPro) return true;
    if (_sparks >= cost) {
      _sparks -= cost;
      await _storage.write(key: 'sparks', value: _sparks.toString());
      notifyListeners();
      return true;
    }
    return false;
  }
}