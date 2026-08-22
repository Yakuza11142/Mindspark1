import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// A pure Dart, dependency-free mock database & auth service that completely 
/// eliminates the need for `package:supabase_flutter`.
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // In-Memory Database Store
  final Map<String, List<Map<String, dynamic>>> _db = {};
  
  // Local File path for offline persistence (Native platforms)
  File? _localStorageFile;
  
  // Current session mock state
  Map<String, dynamic>? _currentUser;

  /// Pure Dart initialization (replaces Supabase.initialize)
  Future<void> init() async {
    try {
      final dir = Directory.systemTemp;
      _localStorageFile = File('${dir.path}/mindspark_local_db.json');
      if (await _localStorageFile!.exists()) {
        final content = await _localStorageFile!.readAsString();
        final decoded = jsonDecode(content) as Map<String, dynamic>;
        decoded.forEach((key, value) {
          _db[key] = List<Map<String, dynamic>>.from(value);
        });
      }
    } catch (_) {
      // Graceful fallback to pure in-memory store for Web/restricted environments
    }
  }

  // ===========================================================================
  // AUTHENTICATION REPLACEMENTS
  // ===========================================================================

  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<Map<String, dynamic>> signUp({
    required String email, 
    required String password,
  }) async {
    _currentUser = {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'created_at': DateTime.now().toIso8601String(),
    };
    await _persist();
    return _currentUser!;
  }

  Future<Map<String, dynamic>> signIn({
    required String email, 
    required String password,
  }) async {
    _currentUser = {
      'id': 'user_mock_101',
      'email': email,
      'last_sign_in': DateTime.now().toIso8601String(),
    };
    return _currentUser!;
  }

  Future<void> signOut() async {
    _currentUser = null;
  }

  // ===========================================================================
  // DATABASE / CRUD REPLACEMENTS
  // ===========================================================================

  /// Replaces `supabase.from('table').select()`
  Future<List<Map<String, dynamic>>> select(String table) async {
    return List.unmodifiable(_db[table] ?? []);
  }

  /// Replaces `supabase.from('table').insert(data)`
  Future<void> insert(String table, Map<String, dynamic> data) async {
    _db.putIfAbsent(table, () => []);
    final record = Map<String, dynamic>.from(data);
    record['id'] ??= DateTime.now().millisecondsSinceEpoch.toString();
    _db[table]!.add(record);
    await _persist();
  }

  /// Replaces `supabase.from('table').update(data).eq('id', id)`
  Future<void> update(String table, String id, Map<String, dynamic> data) async {
    if (!_db.containsKey(table)) return;
    final index = _db[table]!.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _db[table]![index].addAll(data);
      await _persist();
    }
  }

  /// Replaces `supabase.from('table').delete().eq('id', id)`
  Future<void> delete(String table, String id) async {
    if (!_db.containsKey(table)) return;
    _db[table]!.removeWhere((item) => item['id'] == id);
    await _persist();
  }

  // Internal persistence helper
  Future<void> _persist() async {
    if (_localStorageFile != null) {
      try {
        await _localStorageFile!.writeAsString(jsonEncode(_db));
      } catch (_) {}
    }
  }
}
