import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge/domain/model/models.dart';
import 'package:flutter_challenge/domain/usecase/get_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._getOrdersUsecase) : super(const OrdersState.initial()) {
    getOrders();
  }
  final GetOrdersUsecase _getOrdersUsecase;

  Future<void> getOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));
    await Future.delayed(const Duration(seconds: 2));

    try {
      // ignore: void_checks
      final orders = await _getOrdersUsecase.execute(null);

      emit(state.copyWith(orders: orders));
      emit(state.copyWith(status: OrdersStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: OrdersStatus.failure));
      emit(state.copyWith(error: e.toString()));
    }
  }
}
