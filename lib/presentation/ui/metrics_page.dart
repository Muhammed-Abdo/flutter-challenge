import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/app/constants.dart';
import 'package:flutter_challenge/presentation/cubit/orders_cubit.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppConstants.orderMetrics,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      )),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.status == OrdersStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == OrdersStatus.failure) {
            return Center(
                child:
                    Text('${AppConstants.failedToLoadOrders} ${state.error}'));
          } else if (state.status == OrdersStatus.loaded) {
            final totalOrders = state.orders.length;
            final averagePrice = state.orders.isNotEmpty
                ? state.orders.map((o) => o.price).reduce((a, b) => a + b) /
                    totalOrders
                : 0.0;
            final totalReturned = state.orders
                .where((o) => o.status == AppConstants.returnedStatus)
                .length;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.shopping_bag_outlined,
                                        size: 20),
                                    const SizedBox(width: 5),
                                    Text(AppConstants.totalOrders,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(totalOrders.toString(),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Text(AppConstants.allTimeOrders,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ))),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money_outlined,
                                        size: 20),
                                    const SizedBox(width: 5),
                                    Text(AppConstants.averageOrderPrice,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text('\$${averagePrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Text(AppConstants.perOrder,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ))),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.undo_outlined, size: 20),
                                    const SizedBox(width: 5),
                                    Text(AppConstants.returnedOrders,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text('$totalReturned',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Text(AppConstants.returnedOrdersDescription,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ))),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
