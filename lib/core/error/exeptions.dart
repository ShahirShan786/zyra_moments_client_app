// Create these custom exception classes in your core/error folder

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  
  @override
  String toString() =>  message;
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
  
  @override
  String toString() =>  message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => message;
}