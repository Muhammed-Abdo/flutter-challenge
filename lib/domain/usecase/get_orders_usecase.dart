import 'package:flutter_challenge/domain/model/models.dart';
import 'package:flutter_challenge/domain/repository/repository.dart';
import 'package:flutter_challenge/domain/usecase/base_usecase.dart';

class GetOrdersUsecase implements BaseUsecase<void, Order> {
  final Repository _repository;

  GetOrdersUsecase(this._repository);

  @override
  Future<List<Order>> execute(void input) {
    return _repository.getOrders();
  }
}
