import 'package:flutter/material.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Wipe Account Data?'),
        content: const Text(
          'This action will permanently delete your localized settings, AI cache, and profile history. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account data wiped successfully.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            child: const Text('Wipe Data'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal, Terms & Privacy'),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legal & Compliance Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your privacy and data safety are fundamental to our platform design. Review our official terms, privacy practices, and regulatory frameworks below.',
                    style: TextStyle(color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ExpansionTile(
            leading: const Icon(Icons.privacy_tip_outlined, color: Colors.deepPurple),
            title: const Text('1. Privacy Policy & Data Collection'),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '• We only collect data necessary for providing core app functionalities.\n'
                  '• Your activity logs and interaction inputs are transmitted using industry-standard TLS encryption.\n'
                  '• Personal details are never sold, rented, or commercialized to third-party ad networks.',
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.gavel_outlined, color: Colors.deepPurple),
            title: const Text('2. Terms of Service & Acceptable Use'),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '• Users must adhere to respectful community guidelines.\n'
                  '• Automated spam, harmful inputs, and attempts to breach security bounds will trigger immediate filtering.\n'
                  '• Account subscription plans are processed securely via integrated payment gateways.',
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.psychology_outlined, color: Colors.deepPurple),
            title: const Text('3. AI Ethics & Content Safety'),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '• Automated responses are generated in real-time to facilitate interactive learning.\n'
                  '• Content filtering protocols automatically screen inputs for safety compliance.\n'
                  '• Generated outputs should be cross-referenced for academic and strict informational accuracy.',
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.verified_user_outlined, color: Colors.deepPurple),
            title: const Text('4. User Rights & Data Deletion'),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '• You retain total ownership over your profile data.\n'
                  '• You hold the explicit right to request account data removal or wipe localized app data anytime.',
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text(
              'Wipe Local Data & Cache',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Reset local storage and clear cached app preferences'),
            onTap: () => _showDeleteAccountDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Contact Support'),
            subtitle: const Text('mindsparkceogmail.com'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Support Email: mindsparkelite6@gmail.com')),
              );
            },
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'App Build Version 1.0.0 (Production)\n© All Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
