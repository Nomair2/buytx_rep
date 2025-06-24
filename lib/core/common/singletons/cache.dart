class Cache {
  Cache._internal();

  static final Cache instance = Cache._internal();

  String? _sessionToken;
  String? _idUser;

  String? get sessionToken => _sessionToken;
  String? get idUser => _idUser;

  void setSessionToken(String? newToken) {
    if (_sessionToken != newToken) _sessionToken = newToken;
  }

  void setIdUser(String? newIdUser) {
    if (_idUser != newIdUser) _idUser = newIdUser;
  }

  void resetSession() {
    setIdUser(null);
    setSessionToken(null);
  }
}
