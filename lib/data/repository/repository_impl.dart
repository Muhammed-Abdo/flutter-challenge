import 'package:flutter_challenge/data/data_source/local_data_source.dart';
import 'package:flutter_challenge/data/exceptions/exceptions.dart';
import 'package:flutter_challenge/data/mapper/mapper.dart';
import 'package:flutter_challenge/domain/model/models.dart';
import 'package:flutter_challenge/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _dataSource;

  RepositoryImpl(this._dataSource);

  @override
  Future<List<Order>> getOrders() async {
    try {
      final responses = await _dataSource.getOrders();
      return responses.map((response) => response.toDomain()).toList();
    } catch (e) {
      if (e is DataSourceException) {
        throw RepositoryException('Data source error: ${e.message}');
      }
      throw RepositoryException('Unknown repository error: ${e.toString()}');
    }
  }
}
