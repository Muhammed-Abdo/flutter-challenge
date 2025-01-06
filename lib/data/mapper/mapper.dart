import 'package:flutter_challenge/app/constants.dart';
import 'package:flutter_challenge/app/extensions.dart';
import 'package:flutter_challenge/data/responses/response.dart';
import 'package:flutter_challenge/domain/model/models.dart';

extension OrderResponseMapper on OrderResponse? {
  Order toDomain() {
    return Order(
      id: this?.id.notNull() ?? Constants.empty,
      isActive: this?.isActive.notNull() ?? Constants.falseBool,
      price: _parsePrice(this?.price).notNull(),
      company: this?.company.notNull() ?? Constants.empty,
      picture: this?.picture.notNull() ?? Constants.empty,
      buyer: this?.buyer.notNull() ?? Constants.empty,
      tags: this?.tags.notNull() ?? Constants.emptyList,
      status: this?.status.notNull() ?? Constants.empty,
      registered: this?.registered.orNow() ?? DateTime.now(),
    );
  }

  double? _parsePrice(String? priceStr) {
    return double.parse(priceStr?.replaceAll(RegExp(r'[\$,]'), '') ?? '');
  }
}
