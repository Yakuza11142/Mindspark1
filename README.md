# Mind Spark ⚡

Mind Spark is a Flutter mobile application for Android featuring integrated Augmented Reality (AR) capabilities and a cloud backend. 

## 🚀 Features

* **AR Integration**: Uses Google ARCore for real-time camera tracking and overlay features.
* **Cloud Backend**: Powered by Supabase for real-time database management and authentication.
* **Automated Builds**: Includes a secure CI/CD pipeline that signs, obfuscates, and builds production APKs automatically.

## 🛠️ Required Permissions

The app utilizes the following Android system permissions:
* `CAMERA` - For AR tracking and real-time feeds.
* `RECORD_AUDIO` - For sound and voice features.
* `INTERNET` & `ACCESS_NETWORK_STATE` - For cloud synchronization with Supabase.
* `VIBRATE` & `WAKE_LOCK` - For physical haptic interactions and preventing screen sleep.

---

## 💻 Local Development

### Prerequisites
* [Flutter SDK](https://flutter.dev/docs/get-started/install) (Stable Channel)
* Android Studio / Android SDK

### Setup Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Mindspark1.git
   cd Mindspark1
   ```

2. **Configure Environment Variables**:
   Create a local `.env` file inside the `assets/` directory to prevent runtime configuration crashes:
   ```bash
   mkdir -p assets
   echo "SUPABASE_URL=your_supabase_url_here" > assets/.env
   echo "SUPABASE_ANON_KEY=your_supabase_anon_key_here" >> assets/.env
   ```

3. Fetch the required dependencies:
   ```bash
   flutter pub get
   ```

4. Run the project on your connected device:
   ```bash
   flutter run
   ```

---

## 📦 Production Builds (GitHub Actions)

This repository includes a continuous integration workflow (`.github/workflows/`) that automatically builds your app on every push to the `main` or `master` branches.

It automatically takes care of:
1. Injecting production `SUPABASE_URL` and `SUPABASE_ANON_KEY` secrets from GitHub Settings.
2. Generating a clean `AndroidManifest.xml` during runtime.
3. Compiling an obfuscated release build (`app-release.apk`) to prevent reverse-engineering.
4. Exporting build symbols and cryptographic hashes for verification.
