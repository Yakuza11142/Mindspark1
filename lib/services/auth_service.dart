import 'package:supabase_auth/supabase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final SupabaseAuth _auth = SupabaseAuth.instance;

  // 1. Sign In with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

  // 2. Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 3. Get Current User ID
  String? get userId => _auth.currentUser?.uid;
}