import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_profile_model.dart';

class UserRepository {
  final _supabase = Supabase.instance.client;

  Future<UserProfileModel?> getUserProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final data = await _supabase.from('profiles').select().eq('id', user.id).single();
    return UserProfileModel.fromJson(data);
  }

  Future<void> updateSparks(int newAmount) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('profiles').update({'sparks': newAmount}).eq('id', user.id);
  }
}