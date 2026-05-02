class StringValidators {
  static bool isValidEmail(String email) => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  static bool isStrongPassword(String pass) => pass.length >= 8;
}