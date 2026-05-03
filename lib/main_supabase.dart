import 'package:flutter/material.dart';
import 'services/supabase_initializer.dart';
import 'widgets/auth_state_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseInitializer.init(); // Wakes up the database
  
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthStateWrapper(), // Automatically checks if logged in
  ));
}