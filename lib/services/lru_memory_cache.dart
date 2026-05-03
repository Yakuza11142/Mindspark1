import 'dart:collection';

class LruMemoryCache<K, V> {
  final int capacity;
  final LinkedHashMap<K, V> _cache = LinkedHashMap<K, V>();

  LruMemoryCache(this.capacity);

  V? get(K key) {
    if (!_cache.containsKey(key)) return null;
    // Move to end (most recently used)
    final value = _cache.remove(key) as V;
    _cache[key] = value;
    return value;
  }

  void put(K key, V value) {
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else if (_cache.length >= capacity) {
      // Remove the oldest (first) item
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }
  
  void clear() => _cache.clear();
}