extension StringExt on String {
  Map<String, dynamic> get toAuthHeader {
    return {
      'Authorization': 'Bearer ${this}',
      'Content-Type': 'application/json; charset=UTF-8'
    };
  }
}
