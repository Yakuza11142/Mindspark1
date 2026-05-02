import 'dart:math';

class OmniCoreMegalith {
  // --- MATH & ALGEBRA (1-20) ---
  static double add(double a, double b) => a + b;
  static double sub(double a, double b) => a - b;
  static double mul(double a, double b) => a * b;
  static double div(double a, double b) => b != 0 ? a / b : 0;
  static double sqr(double a) => a * a;
  static double cub(double a) => a * a * a;
  static double root(double a) => sqrt(a);
  static double cbrt(double a) => pow(a, 1/3).toDouble();
  static bool isEven(int a) => a % 2 == 0;
  static bool isOdd(int a) => a % 2 != 0;
  static int mod(int a, int b) => a % b;
  static double pythagoras(double a, double b) => sqrt(a*a + b*b);
  static double areaCircle(double r) => pi * r * r;
  static double circumCircle(double r) => 2 * pi * r;
  static double areaRect(double w, double h) => w * h;
  static double volCube(double s) => s * s * s;
  static double volCyl(double r, double h) => pi * r * r * h;
  static double volSphere(double r) => (4/3) * pi * pow(r, 3).toDouble();
  static double degToRad(double deg) => deg * (pi / 180);
  static double radToDeg(double rad) => rad * (180 / pi);

  // --- PHYSICS & KINEMATICS (21-40) ---
  static double vel(double d, double t) => d / t;
  static double accel(double v, double u, double t) => (v - u) / t;
  static double force(double m, double a) => m * a;
  static double weight(double m) => m * 9.81;
  static double momentum(double m, double v) => m * v;
  static double kineticEnergy(double m, double v) => 0.5 * m * v * v;
  static double potentialEnergy(double m, double h) => m * 9.81 * h;
  static double work(double f, double d) => f * d;
  static double power(double w, double t) => w / t;
  static double density(double m, double v) => m / v;
  static double pressure(double f, double a) => f / a;
  static double frequency(double period) => 1 / period;
  static double waveSpeed(double freq, double wavelength) => freq * wavelength;
  static double ohmsLawV(double i, double r) => i * r;
  static double ohmsLawI(double v, double r) => v / r;
  static double ohmsLawR(double v, double i) => v / i;
  static double electricalPower(double v, double i) => v * i;
  static double heatEnergy(double m, double c, double dt) => m * c * dt;
  static double gravityForce(double m1, double m2, double r) => (6.674e-11 * m1 * m2) / (r * r);
  static double escapeVelocity(double m, double r) => sqrt((2 * 6.674e-11 * m) / r);

  // --- STRING MANIPULATION (41-60) ---
  static String capFirst(String s) => s.isEmpty ? "" : "${s[0].toUpperCase()}${s.substring(1)}";
  static String lowerAll(String s) => s.toLowerCase();
  static String upperAll(String s) => s.toUpperCase();
  static String removeSpaces(String s) => s.replaceAll(' ', '');
  static String extractDigits(String s) => s.replaceAll(RegExp(r'\D'), '');
  static String extractLetters(String s) => s.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  static bool hasNumbers(String s) => RegExp(r'\d').hasMatch(s);
  static bool hasLetters(String s) => RegExp(r'[a-zA-Z]').hasMatch(s);
  static int wordCount(String s) => s.trim().split(RegExp(r'\s+')).length;
  static String reverseStr(String s) => s.split('').reversed.join('');
  static bool isPalindrome(String s) => s == reverseStr(s);
  static String toSnakeCase(String s) => s.replaceAll(' ', '_').toLowerCase();
  static String toKebabCase(String s) => s.replaceAll(' ', '-').toLowerCase();
  static String toCamelCase(String s) => s.split(' ').map(capFirst).join('');
  static String stripHtml(String s) => s.replaceAll(RegExp(r'<[^>]*>'), '');
  static String firstWord(String s) => s.split(' ').first;
  static String lastWord(String s) => s.split(' ').last;
  static String initials(String s) => s.split(' ').map((w) => w.isNotEmpty ? w[0] : '').join('').toUpperCase();
  static String repeatStr(String s, int n) => List.filled(n, s).join();
  static bool isEmailValid(String s) => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);

  // --- DATA VALIDATION & UTILS (61-80) ---
  static bool isPassStrong(String p) => p.length >= 8 && hasNumbers(p) && hasLetters(p);
  static bool isPhoneValid(String p) => extractDigits(p).length >= 10;
  static bool isUrlValid(String u) => Uri.tryParse(u)?.hasAbsolutePath ?? false;
  static bool isNumeric(String s) => double.tryParse(s) != null;
  static bool isBoolStr(String s) => s.toLowerCase() == 'true' || s.toLowerCase() == 'false';
  static int boolToInt(bool b) => b ? 1 : 0;
  static bool intToBool(int i) => i == 1;
  static String listToString(List<String> l) => l.join(', ');
  static List<String> stringToList(String s) => s.split(', ');
  static double maxInList(List<double> l) => l.reduce(max);
  static double minInList(List<double> l) => l.reduce(min);
  static double sumList(List<double> l) => l.fold(0, (a, b) => a + b);
  static double avgList(List<double> l) => sumList(l) / l.length;
  static List<double> sortAsc(List<double> l) { l.sort(); return l; }
  static List<double> sortDesc(List<double> l) { l.sort((a,b) => b.compareTo(a)); return l; }
  static int getRandomInt(int min, int max) => min + Random().nextInt(max - min);
  static double getRandomDouble() => Random().nextDouble();
  static bool coinFlip() => Random().nextBool();
  static String genUuid() => "${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(9999)}";
  static int calcAge(int birthYear) => DateTime.now().year - birthYear;

  // --- NAIJA/FINANCE/TIME (81-100) ---
  static double usdToNgn(double usd, double rate) => usd * rate;
  static double ngnToUsd(double ngn, double rate) => ngn / rate;
  static String formatNaira(double amt) => "₦${amt.toStringAsFixed(0)}";
  static String formatUsd(double amt) => "\$${amt.toStringAsFixed(2)}";
  static double applyDiscount(double price, double pct) => price - (price * (pct / 100));
  static double addVat(double price, double pct) => price + (price * (pct / 100));
  static int getDaysInMonth(int m, int y) => DateTime(y, m + 1, 0).day;
  static bool isLeapYear(int y) => (y % 4 == 0) && ((y % 100 != 0) || (y % 400 == 0));
  static String timestampToDate(int ms) => DateTime.fromMillisecondsSinceEpoch(ms).toIso8601String().split('T')[0];
  static int dateToTimestamp(DateTime d) => d.millisecondsSinceEpoch;
  static int daysBetween(DateTime a, DateTime b) => a.difference(b).inDays.abs();
  static int hoursBetween(DateTime a, DateTime b) => a.difference(b).inHours.abs();
  static int minsBetween(DateTime a, DateTime b) => a.difference(b).inMinutes.abs();
  static String timeAgo(int ms) { int s = (DateTime.now().millisecondsSinceEpoch - ms) ~/ 1000; if(s<60) return "${s}s ago"; if(s<3600) return "${s~/60}m ago"; return "${s~/3600}h ago"; }
  static int getJambScore(int a, int b, int c, int d) => a + b + c + d;
  static double calcPostUtme(int jamb, int post) => ((jamb/400)*50) + ((post/100)*50);
  static bool isPassingJamb(int score, int cutoff) => score >= cutoff;
  static String getWaecGrade(int pct) { if(pct>=75)return'A1'; if(pct>=70)return'B2'; if(pct>=65)return'B3'; if(pct>=60)return'C4'; if(pct>=50)return'C6'; return'F9'; }
  static int estimateReadingTime(String text) => (wordCount(text) / 200).ceil(); // 200 words per min
  static String censorWord(String w) => w[0] + repeatStr('*', w.length - 2) + w[w.length - 1];
}