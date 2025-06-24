abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;

  AuthAuthenticated(this.userId);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthSuccess extends AuthState {}

class AuthOtpSent extends AuthState {
  final String phoneNumber;

  AuthOtpSent(this.phoneNumber);
}

class AuthOtpVerified extends AuthState {
  final String userId;

  AuthOtpVerified(this.userId);
}

class AuthPasswordResetSuccess extends AuthState {}

class AuthGoogleSignupSuccess extends AuthState {
  final String userId;

  AuthGoogleSignupSuccess(this.userId);
}
