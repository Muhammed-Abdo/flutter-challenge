import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_challenge/data/exceptions/exceptions.dart';
import 'package:flutter_challenge/data/responses/response.dart';

abstract class LocalDataSource {
  Future<List<OrderResponse>> getOrders();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<OrderResponse>> getOrders() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/api/data/orders.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => OrderResponse.fromJson(json)).toList();
    } catch (e) {
      throw DataSourceException('Error loading local orders: ${e.toString()}');
    }
  }
}
