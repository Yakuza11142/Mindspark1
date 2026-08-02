class StringValidators {
  // 1. RFC-compliant email regex pattern with start (^) and end ($) anchors handles subdomains and modern extensions safely
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  // 2. Strict password rules enforce complex character requirements to prevent brute-force attacks
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
  );

  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return _emailRegex.hasMatch(email.trim());
  }

  static bool isStrongPassword(String pass) {
    if (pass.isEmpty) return false;
    return _passwordRegex.hasMatch(pass);
  }
}
