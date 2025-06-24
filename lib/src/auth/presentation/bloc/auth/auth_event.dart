// auth_event.dart
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});
}

class AuthSignupEvent extends AuthEvent {
  final String username;
  final String fullname;
  final String phone;
  final List<String> authprovider;
  final String password;
  final String email;

  AuthSignupEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.authprovider,
  });
}

class AuthVerifyAccountEvent extends AuthEvent {
  final String email;

  AuthVerifyAccountEvent(this.email);
}

class AuthReVerifyAccountEvent extends AuthEvent {
  final String email;

  AuthReVerifyAccountEvent(this.email);
}

class AuthVerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  AuthVerifyOtpEvent({required this.otp, required this.email});
}

class AuthSignupWithGoogleEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthInitEvent extends AuthEvent {}
