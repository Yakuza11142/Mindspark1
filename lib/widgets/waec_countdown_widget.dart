import '../config/supabase_core_config.dart';

class ExamService {
  ExamService._internal();
  static final ExamService instance = ExamService._internal();

  /// Fetches global exam status from the Edge
  Future<Map<String, dynamic>> getExamStatus() async {
    final user = SupabaseCoreConfig.client.auth.currentUser;
    if (user == null) return {'showCountdown': false};

    try {
      // Pull user metadata (birth_date, class) from your profiles table
      final profile = await SupabaseCoreConfig.client
          .from('profiles')
          .select('birth_date, current_class')
          .single();

      final response = await SupabaseCoreConfig.client.functions.invoke(
        'exam-countdown',
        body: {
          'birthDate': profile['birth_date'],
          'currentClass': profile['current_class'],
        },
      );
      return response.data;
    } catch (e) {
      return {'showCountdown': false, 'error': e.toString()};
    }
  }
}
class GlobalExamCountdown extends StatelessWidget {
  const GlobalExamCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ExamService.instance.getExamStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        
        final data = snapshot.data!;
        if (!data['showCountdown']) return const Text("Keep studying! 📖");

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber),
          ),
          child: Text(
            data['isExamPeriod'] 
                ? "🔥 WAEC IS LIVE!" 
                : "⏳ WAEC 2026: ${data['days']} DAYS",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        );
      },
    );
  }
}
// supabase/functions/exam-countdown/index.ts
import { serve } from "https://deno.land"

serve(async (req) => {
  const { birthDate, currentClass } = await req.json();
  
  // Official WAEC 2026 Start Date: April 21, 2026
  const examDate = new Date('2026-04-21T09:00:00Z');
  const now = new Date();
  
  // Calculate Age
  const age = now.getFullYear() - new Date(birthDate).getFullYear();
  
  // Eligibility: Must be in SS3 or meet the age threshold (typically 15-18)
  const isCandidate = currentClass === 'SS3' || (age >= 16 && age <= 19);
  
  const diffTime = examDate.getTime() - now.getTime();
  const daysLeft = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

  return new Response(JSON.stringify({
    showCountdown: isCandidate,
    days: daysLeft > 0 ? daysLeft : 0,
    isExamPeriod: daysLeft <= 0 && daysLeft >= -60, // True during the 2-month exam window
    status: daysLeft < 0 ? "EXAM IN PROGRESS" : "UPCOMING"
  }), { headers: { "Content-Type": "application/json" } });
})
