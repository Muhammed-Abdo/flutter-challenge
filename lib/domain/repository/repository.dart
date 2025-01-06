import 'package:flutter_challenge/domain/model/models.dart';

abstract class Repository {
  Future<List<Order>> getOrders();
}
