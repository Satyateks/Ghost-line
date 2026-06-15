class Validators {
  Validators._();

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Email is required';

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(text)) return 'Enter a valid email';
    return null;
  }

  static String? mobile(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Mobile number is required';
    if (text.length != 10) return 'Enter 10 digit mobile number';

    final regex = RegExp(r'^[6-9]\d{9}$');
    if (!regex.hasMatch(text)) return 'Enter a valid mobile number';

    return null;
  }

  static String? emailOrMobile(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Email or mobile is required';

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!emailRegex.hasMatch(text) && !mobileRegex.hasMatch(text)) {
      return 'Enter valid email or mobile number';
    }

    return null;
  }

  static String? password(String? value) {
    final text = value ?? '';

    if (text.isEmpty) return 'Password is required';
    if (text.length < 6) return 'Password must be at least 6 characters';

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final text = value ?? '';

    if (text.isEmpty) return 'Confirm password is required';
    if (text != password) return 'Password does not match';

    return null;
  }

  static String? username(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Username is required';
    if (text.length < 3) return 'Username must be at least 3 characters';
    if (text.length > 20) return 'Username cannot exceed 20 characters';

    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(text)) {
      return 'Only letters, numbers and underscore allowed';
    }

    return null;
  }

  static String? otp(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'OTP is required';
    if (text.length != 6) return 'Enter 6 digit OTP';

    return null;
  }

  static String? message(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Message cannot be empty';
    if (text.length > 1000) return 'Message is too long';

    return null;
  }
}
