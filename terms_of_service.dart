import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SparkLegalScreen extends StatefulWidget {
  const SparkLegalScreen({super.key});

  @override
  State<SparkLegalScreen> createState() => _SparkLegalScreenState();
}

class _SparkLegalScreenState extends State<SparkLegalScreen> {
  bool _isChecked = false;

  final String _tosMarkdown = """
# Terms of Service & User Safety
**Last Updated: May 2024**

Welcome to **Spark AR**. Please read these terms carefully before projecting your first hologram.

## 1. Age Requirement (13+)
By using Spark AR, you represent and warrant that you are **at least 13 years of age**. If you are under 18, you must have permission from a parent or legal guardian who agrees to be bound by these terms.

## 2. Device Compatibility & AR Core
Spark AR utilizes advanced spatial tracking. 
* **Compatibility:** This app is designed for devices certified for *Google Play Services for AR* (such as the Samsung A71).
* **Automated Setup:** If your device lacks the required AR components, the app will automatically prompt you to download or update the necessary software from the Google Play Store. **You do not need to download these files manually.**
* **Hardware Limits:** Older devices or those with damaged cameras/sensors may experience "tracking drift" or be unable to launch the AR experience.

## 3. Real-World Tracking & Privacy
To place the "Spark" hologram, the app uses your camera to scan physical surfaces (floors, tables). 
* **Environmental Mapping:** This data is processed locally on your device to anchor the hologram.
* **Camera Access:** We do not record, store, or transmit your private video feed or spatial maps to our servers.

## 4. Physical Safety Warning ⚠️
**AR immersion can lead to physical accidents if you are not careful.**
* **Awareness:** Always stay aware of your actual surroundings. Do not walk into walls, furniture, or traffic while looking through the screen.
* **Hazardous Areas:** Never use Spark AR on public roads, near stairways, or in crowded areas.
* **Supervision:** We recommend adult supervision for younger users to ensure they remain in a safe, clear physical space.

## 5. Limitation of Liability
The developers of Mind Spark are not responsible for any physical injury, property damage, or legal issues arising from your use of the application in the real world. You use the AR features at your own risk.

## 6. Children's Privacy (COPPA Compliance)
Spark AR is a general audience app and is **not directed to children under the age of 13**. In compliance with the *Children’s Online Privacy Protection Act (COPPA)*:
* We do not knowingly collect personal information from children under 13.
* If we become aware that a child under 13 has provided us with personal data, we will take steps to delete such information and terminate the child's account immediately.
* If you are a parent or guardian and believe your child has provided us with personal data, please contact us.

## 7. Data Protection (GDPR Compliance)
For users in the European Union (EU) and European Economic Area (EEA), we process data in accordance with the *General Data Protection Regulation (GDPR)*:
* **Lawful Basis:** We process your spatial and camera data based on your **explicit consent** provided when you enable AR features.
* **Your Rights:** You have the right to access, correct, or request the deletion of your data at any time.
* **Data Minimization:** We only process the camera data necessary to anchor the "Spark" hologram. This tracking data stays on your device and is not stored on our servers.

## 8. Real-World Safety & Compatibility
* **Age Requirement:** You must be 13+ to use this app.
* **Device Support:** Your Samsung A71 is compatible. If AR components are missing, the app will automatically prompt a download of *Google Play Services for AR*.
* **Tracking:** We scan surfaces locally. No private video feed is ever recorded or shared.
* **Physical Safety:** Stay aware of your surroundings to avoid injury. Use Spark at your own risk

## 9. Local Edge Processing & Student Data
To ensure maximum privacy and speed on your device (Samsung A71), this app uses **Edge Computing** for all student-related information:
* **No Cloud Storage:** Student names, IDs, and performance data are stored locally in an encrypted database on this device only. 
* **Local Rendering:** The "Spark" hologram is generated using the phone's internal processor. No camera feed or student data is transmitted to our servers or any third-party cloud providers.
* **Data Control:** Because data is stored on the "Edge," deleting the app from this device will permanently erase all locally stored student records.

## 10. Compliance (COPPA & GDPR)
By processing data at the Edge, Spark AR adheres to the strictest privacy standards:
* **COPPA:** Since no data is collected or transmitted, we do not build profiles on student users.
* **GDPR:** Users maintain full "Right to Access" and "Right to Erasure" because they have physical control over the device where the data lives.


## 11. Third-Party Software
By using this app, you also agree to the [Google Terms of Service](https://google.com) and [Google Privacy Policy](https://google.com) regarding the use of ARCore technology.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Legal & Safety Agreement"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // The Long Text Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Markdown(
                data: _tosMarkdown,
                styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                  h2: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 2),
                  p: const TextStyle(fontSize: 15, height: 1.5),
                  listBullet: const TextStyle(color: Colors.indigo),
                ),
              ),
            ),
          ),

          // Accept Checkbox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CheckboxListTile(
              activeColor: Colors.indigo,
              title: const Text(
                "I am 13 or older and I agree to the safety and device terms.",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              value: _isChecked,
              onChanged: (val) => setState(() => _isChecked = val!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),

          // Action Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isChecked ? Colors.indigo : Colors.grey,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: _isChecked 
                ? () { /* Code to launch your AR Camera screen goes here */ } 
                : null,
              child: const Text(
                "LAUNCH SPARK AR",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
