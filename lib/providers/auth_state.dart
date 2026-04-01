sealed class AuthState {
  const AuthState();
}

class Authenticated extends AuthState {
  final String token;
  final String userId;
  final String refreshToken;
  final DateTime expirationDate;

  const Authenticated({
    required this.token,
    required this.userId,
    required this.refreshToken,
    required this.expirationDate,
  });
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}
