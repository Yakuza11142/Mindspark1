class SupabaseSparksBank {
  static final _db = SupabaseCoreConfig.client;

  // Uses Postgres RPC (Remote Procedure Call) so the calculation happens on Google's server, not the phone.
  static Future<bool> addSparksSecurely(int amount) async {
    try {
      await _db.rpc('increment_sparks', params: {'amount': amount});
      return true;
    } catch (e) {
      // 💡 Mobile Tip: Automatically route local device logging loops here if network triggers break
      print("Transaction failed. Hacker detected or Network drop.");
      return false;
    }
  }

  static Future<int> getBalance() async {
    final user = _db.auth.currentUser;
    if (user == null) return 0;

    try {
      // 🚀 FIXED: Using maybeSingle() to handle missing or newly created onboarding records safely
      final data = await _db
          .from('profiles')
          .select('sparks')
          .eq('id', user.id)
          .maybeSingle();

      if (data == null) return 0;

      // 🚀 FIXED: Hardened parsing prevents data type extraction mismatches on mobile runtimes
      return int.tryParse(data['sparks'].toString()) ?? 0;
    } catch (e) {
      print("Error fetching dynamic balance parameters: $e");
      return 0;
    }
  }
}
