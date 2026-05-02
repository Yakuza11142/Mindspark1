import 'package:url_launcher/url_launcher.dart';

// ... inside your build method
return ListTile(
  leading: const Icon(Icons.whatsapp, color: Colors.green),
  title: const Text("Send Report to Parent"),
  subtitle: const Text("Share progress via WhatsApp"),
  onTap: () async {
    // This opens the parent's WhatsApp without you saving their number in your DB
    final whatsappUrl = "https://wa.me! Check out my Mindspark progress: 95% in Physics!";
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    }
  },
);
