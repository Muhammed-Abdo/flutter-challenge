part of 'orders_cubit.dart';

enum OrdersStatus { initial, loading, loaded, failure }

class OrdersState extends Equatable {
  const OrdersState._({
    required this.status,
    required this.orders,
    required this.error,
  });

  const OrdersState.initial()
      : this._(status: OrdersStatus.initial, orders: const [], error: '');

  @override
  List<Object?> get props => [status, orders, error];

  final OrdersStatus status;
  final List<Order> orders;
  final String error;

  OrdersState copyWith({
    OrdersStatus? status,
    List<Order>? orders,
    String? error,
  }) {
    return OrdersState._(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}
