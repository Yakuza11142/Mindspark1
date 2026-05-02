import 'dart:math';

class OmniMegalith {
  // ===========================================================================
  // SECTION 1: STRING & TEXT FORMATTING (Functions 1-25)
  // ===========================================================================
  static String capitalize(String s) => s.isEmpty ? "" : "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  static String titleCase(String s) => s.split(' ').map((w) => capitalize(w)).join(' ');
  static String truncate(String s, int len) => s.length > len ? "${s.substring(0, len)}..." : s;
  static int wordCount(String s) => s.trim().split(RegExp(r'\s+')).length;
  static String removeSpecialChars(String s) => s.replaceAll(RegExp(r'[^\w\s]+'), '');
  static String extractNumbers(String s) => s.replaceAll(RegExp(r'[^0-9.]'), '');
  static String extractLetters(String s) => s.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  static bool isPalindrome(String s) { String cl = s.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase(); return cl == cl.split('').reversed.join(''); }
  static String reverseString(String s) => s.split('').reversed.join('');
  static String toSnakeCase(String s) => s.replaceAll(' ', '_').toLowerCase();
  static String toKebabCase(String s) => s.replaceAll(' ', '-').toLowerCase();
  static String stripHtml(String s) => s.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  static bool containsProfanity(String s) => RegExp(r'\b(fuck|shit|bitch|cunt|ass)\b', caseSensitive: false).hasMatch(s);
  static String maskEmail(String email) { var p = email.split('@'); return "${p[0].substring(0, 2)}***@${p[1]}"; }
  static String formatPhone(String phone) => phone.replaceAll(RegExp(r'\D'), '');
  static String getInitials(String name) => name.trim().split(' ').map((n) => n.isNotEmpty ? n[0].toUpperCase() : '').join().substring(0, min(2, name.split(' ').length));
  static bool isNullOrEmpty(String? s) => s == null || s.trim().isEmpty;
  static String formatBytes(int bytes) { if (bytes <= 0) return "0 B"; const suffixes =["B", "KB", "MB", "GB", "TB"]; var i = (log(bytes) / log(1024)).floor(); return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}'; }
  static String pluralize(int count, String singular, [String? plural]) => count == 1 ? singular : (plural ?? "${singular}s");
  static String randomString(int length) { const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'; return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length)))); }
  static int countVowels(String s) => RegExp(r'[aeiouAEIOU]').allMatches(s).length;
  static int countConsonants(String s) => RegExp(r'[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]').allMatches(s).length;
  static String repeatString(String s, int n) => List.filled(n, s).join();
  static bool isNumeric(String s) => double.tryParse(s) != null;
  static String padLeft(String s, int width, [String padding = ' ']) => s.padLeft(width, padding);

  // ===========================================================================
  // SECTION 2: MATH & PHYSICS CALCULATORS (Functions 26-50)
  // ===========================================================================
  static const double G = 6.67430e-11;
  static const double gEarth = 9.81;
  static const double cLight = 299792458;
  static double calcVelocity(double u, double a, double t) => u + (a * t);
  static double calcDistance(double u, double a, double t) => (u * t) + (0.5 * a * t * t);
  static double calcForce(double m, double a) => m * a;
  static double calcKineticEnergy(double m, double v) => 0.5 * m * v * v;
  static double calcPotentialEnergy(double m, double h) => m * gEarth * h;
  static double calcMomentum(double m, double v) => m * v;
  static double calcWork(double f, double d, double theta) => f * d * cos(theta * pi / 180);
  static double calcPower(double w, double t) => w / t;
  static double calcDensity(double m, double v) => m / v;
  static double calcPressure(double f, double a) => f / a;
  static double ohmsLawV(double i, double r) => i * r;
  static double ohmsLawI(double v, double r) => v / r;
  static double ohmsLawR(double v, double i) => v / i;
  static double pythagorasHypotenuse(double a, double b) => sqrt(a * a + b * b);
  static double pythagorasLeg(double c, double a) => sqrt(c * c - a * a);
  static double circleArea(double r) => pi * r * r;
  static double circleCircumference(double r) => 2 * pi * r;
  static double cylinderVolume(double r, double h) => pi * r * r * h;
  static double sphereVolume(double r) => (4 / 3) * pi * pow(r, 3);
  static double celsiusToFahrenheit(double c) => (c * 9 / 5) + 32;
  static double fahrenheitToCelsius(double f) => (f - 32) * 5 / 9;
  static double celsiusToKelvin(double c) => c + 273.15;
  static double kelvinToCelsius(double k) => k - 273.15;

  // ===========================================================================
  // SECTION 3: VALIDATION & REGEX (Functions 51-75)
  // ===========================================================================
  static bool isValidEmail(String s) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(s);
  static bool isValidUrl(String s) => RegExp(r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$').hasMatch(s);
  static bool isValidHexColor(String s) => RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(s);
  static bool isValidDate(String s) => DateTime.tryParse(s) != null;
  static bool isValidPhoneNumber(String s) => RegExp(r'^\+?[0-9]{10,14}$').hasMatch(s);
  static bool isAlphaNumeric(String s) => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(s);
  static bool hasUpperCase(String s) => RegExp(r'[A-Z]').hasMatch(s);
  static bool hasLowerCase(String s) => RegExp(r'[a-z]').hasMatch(s);
  static bool hasDigit(String s) => RegExp(r'[0-9]').hasMatch(s);
  static bool hasSpecialChar(String s) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(s);
  static bool isLengthBetween(String s, int min, int max) => s.length >= min && s.length <= max;
  static bool isExactLength(String s, int len) => s.length == len;
  static bool containsOnlyLetters(String s) => RegExp(r'^[a-zA-Z]+$').hasMatch(s);
  static bool containsOnlyDigits(String s) => RegExp(r'^[0-9]+$').hasMatch(s);
  static bool isBooleanStr(String s) => s.toLowerCase() == 'true' || s.toLowerCase() == 'false';
  static bool isIPv4(String s) => RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$').hasMatch(s);
  static bool isMacAddress(String s) => RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(s);
  static bool isJambRegNumber(String s) => RegExp(r'^\d{8}[A-Z]{2}$', caseSensitive: false).hasMatch(s); // Standard JAMB format
  static bool isWaecRegNumber(String s) => RegExp(r'^\d{10}$').hasMatch(s); // Standard WAEC format
  static bool isStrongPasswordPolicy(String s) => s.length >= 8 && hasUpperCase(s) && hasLowerCase(s) && hasDigit(s) && hasSpecialChar(s);
  static bool isBase64(String s) => RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$').hasMatch(s);
  static bool isJSON(String s) { try { import('dart:convert'); jsonDecode(s); return true; } catch (_) { return false; } }
  static bool isCreditCard(String s) => RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$').hasMatch(s.replaceAll(RegExp(r'[^0-9]'), ''));
  static bool isUUID(String s) => RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$').hasMatch(s);
  static bool isMD5(String s) => RegExp(r'^[a-f0-9]{32}$').hasMatch(s);

  // ===========================================================================
  // SECTION 4: TIME, DATE & EXAM SCORING (Functions 76-100)
  // ===========================================================================
  static String currentIsoDate() => DateTime.now().toIso8601String();
  static int currentTimestamp() => DateTime.now().millisecondsSinceEpoch;
  static int daysBetween(DateTime d1, DateTime d2) => d1.difference(d2).inDays.abs();
  static bool isWeekend(DateTime d) => d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;
  static bool isLeapYear(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  static int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;
  static String formatDuration(Duration d) => "${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  static double calcPercentage(int score, int total) => total == 0 ? 0 : (score / total) * 100;
  static int normalizeTo400(int rawScore, int totalQuestions) => ((rawScore / totalQuestions) * 400).round();
  static String getWaecGrade(double pct) { if(pct>=75)return'A1'; if(pct>=70)return'B2'; if(pct>=65)return'B3'; if(pct>=60)return'C4'; if(pct>=55)return'C5'; if(pct>=50)return'C6'; if(pct>=45)return'D7'; if(pct>=40)return'E8'; return'F9'; }
  static String getGcseGrade(double pct) { if(pct>=90)return'9'; if(pct>=80)return'8'; if(pct>=70)return'7'; if(pct>=60)return'6'; if(pct>=50)return'5'; if(pct>=40)return'4'; return'U'; }
  static int calcSatScore(int mathRaw, int readingRaw) { int math = (mathRaw/58)*800; int read = (readingRaw/96)*800; return ((math~/10)*10) + ((read~/10)*10); } // Simplification
  static double calculateGpa(List<double> grades, List<double> credits) { double sum = 0; double totalCredits = 0; for(int i=0; i<grades.length; i++){ sum += grades[i]*credits[i]; totalCredits += credits[i]; } return totalCredits == 0 ? 0 : sum/totalCredits; }
  static bool isPassingJamb(int score, int cutoff) => score >= cutoff;
  static int ageFromDob(DateTime dob) { DateTime now = DateTime.now(); int age = now.year - dob.year; if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) age--; return age; }
  static String greetingByHour(int hour) { if(hour<12)return"Good Morning"; if(hour<17)return"Good Afternoon"; return"Good Evening"; }
  static String getSemester(int month) { if(month>=1&&month<=4)return"Spring"; if(month>=5&&month<=8)return"Summer"; return"Fall"; }
  static int minutesToRead(int wordCount, int wpm) => (wordCount / wpm).ceil();
  static double lerpDoubleCustom(double a, double b, double t) => a + (b - a) * t;
  static double clampCustom(double val, double minVal, double maxVal) => max(minVal, min(maxVal, val));
  static int randomInt(int min, int max) => min + Random().nextInt(max - min);
  static double randomDouble(double min, double max) => min + Random().nextDouble() * (max - min);
  static bool randomChance(double probability) => Random().nextDouble() < probability;
  static String generateId(int length) { const chars = 'abcdefghijklmnopqrstuvwxyz0123456789'; return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length)))); }
  static int getHash(String s) => s.hashCode;
}