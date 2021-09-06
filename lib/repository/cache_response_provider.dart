class CacheProvider<T> {
  final _cache = <String, T>{};

  T get(String term) => _cache[term];

  void set(String term, T result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
