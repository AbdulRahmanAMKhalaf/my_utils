class RegexPatterns {
  /// Email: user@example.com
  static final RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Password: Min 8 chars, at least 1 letter, 1 number, 1 special char
  static final RegExp password = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  /// Phone: +CountryCode + number (9–15 digits)
  static final RegExp phone = RegExp(r'^\+\d{1,3}\d{9,15}$');

  /// Username: Letters, numbers, underscores, 3–16 chars
  static final RegExp username = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
}

class Validator {
  static bool isValidEmail(String email) {
    return RegexPatterns.email.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegexPatterns.password.hasMatch(password);
  }

  static bool isValidPhone(String phone) {
    return RegexPatterns.phone.hasMatch(phone);
  }

  static bool isValidUsername(String username) {
    return RegexPatterns.username.hasMatch(username);
  }
}
