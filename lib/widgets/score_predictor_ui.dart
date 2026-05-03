class GlobalJambPredictor extends StatelessWidget {
  final int averageScore;
  const GlobalJambPredictor({super.key, required this.averageScore});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseCoreConfig.client.functions.invoke('predict-jamb', body: {'averageScore': averageScore}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        
        final data = snapshot.data!.data;
        final Color statusColor = Color(int.parse(data['color'].replaceFirst('#', '0xFF')));

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: statusColor), 
            borderRadius: BorderRadius.circular(10), 
            color: Colors.black87
          ),
          child: Column(
            children: [
              const Text("AI PREDICTED JAMB SCORE", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("${data['predictedJamb']}", style: TextStyle(color: statusColor, fontSize: 40, fontWeight: FontWeight.bold)),
              Text(data['status'], style: TextStyle(color: statusColor)),
            ],
          ),
        );
      },
    );
  }
}
// supabase/functions/predict-jamb/index.ts
import { serve } from "https://deno.land"

serve(async (req) => {
  const { averageScore } = await req.json();
  
  // Weighted Prediction: Can be updated in cloud anytime
  // Standard: (average / 100) * 400
  const basePrediction = (averageScore / 100) * 400;
  const predictedJamb = Math.round(basePrediction);
  
  const status = predictedJamb >= 250 ? "University Ready 🎓" : "High Risk of Failure ⚠️";
  const color = predictedJamb >= 250 ? "#00FF7F" : "#FF4C4C";

  return new Response(JSON.stringify({ predictedJamb, status, color }), {
    headers: { "Content-Type": "application/json" }
  });
})
