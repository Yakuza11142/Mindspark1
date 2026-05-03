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
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrencyManager extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  int _sparks = 100; // New users get 100
  bool _isPro = false;

  int get sparks => _sparks;
  bool get isPro => _isPro;

  Future<void> init() async {
    String? s = await _storage.read(key: 'secure_sparks');
    String? p = await _storage.read(key: 'is_pro');
    if (s != null) _sparks = int.parse(s);
    if (p != null) _isPro = p == 'true';
    notifyListeners();
  }

  Future<void> addSparks(int amount) async {
    _sparks += amount;
    await _storage.write(key: 'secure_sparks', value: _sparks.toString());
    notifyListeners();
  }

  Future<bool> spendSparks(int amount) async {
    if (_isPro) return true; // Pro pays nothing
    if (_sparks >= amount) {
      _sparks -= amount;
      await _storage.write(key: 'secure_sparks', value: _sparks.toString());
      notifyListeners();
      return true;
    }
    return false;
  }
}