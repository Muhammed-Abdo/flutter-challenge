// lib/data/exceptions/exceptions.dart
class DataSourceException implements Exception {
  final String message;
  DataSourceException(this.message);

  @override
  String toString() => message;
}

class ServiceException implements Exception {
  final String message;
  ServiceException(this.message);

  @override
  String toString() => message;
}

class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => message;
}
