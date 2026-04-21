class ErrorMapper {
  const ErrorMapper._();

  static String toMessage(Exception e) {
    final raw = e.toString();

    // HTTP status codes
    if (raw.contains('401') || raw.contains('Unauthorized')) {
      return 'Incorrect email or password.';
    }
    if (raw.contains('403') || raw.contains('Forbidden')) {
      return 'You do not have permission to perform this action.';
    }
    if (raw.contains('404') || raw.contains('Not Found')) {
      return 'Account not found.';
    }
    if (raw.contains('422') || raw.contains('Unprocessable')) {
      return 'Invalid email or password format.';
    }
    if (raw.contains('429') || raw.contains('Too Many')) {
      return 'Too many attempts. Please try again later.';
    }
    if (raw.contains('5')) {
      // 5xx
      if (raw.contains('500') ||
          raw.contains('502') ||
          raw.contains('503') ||
          raw.contains('504')) {
        return 'Server error. Please try again later.';
      }
    }

    // Network / connectivity
    if (raw.contains('SocketException') ||
        raw.contains('NetworkException') ||
        raw.contains('Failed host lookup') ||
        raw.contains('Connection refused')) {
      return 'No internet connection. Please check your network.';
    }
    if (raw.contains('TimeoutException') ||
        raw.contains('timed out') ||
        raw.contains('connect timed out')) {
      return 'Request timed out. Please try again.';
    }

    // DioException — extract message if present
    if (raw.contains('DioException') || raw.contains('DioError')) {
      final match = RegExp(r'"message"\s*:\s*"([^"]+)"').firstMatch(raw);
      if (match != null) return match.group(1)!;
      return 'Something went wrong. Please try again.';
    }

    return 'Something went wrong. Please try again.';
  }
}
