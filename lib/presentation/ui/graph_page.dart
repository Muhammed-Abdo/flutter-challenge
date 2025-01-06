import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_challenge/domain/model/models.dart';
import 'package:flutter_challenge/presentation/cubit/orders_cubit.dart';
import 'package:flutter_challenge/app/constants.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppConstants.ordersGraphTitle,
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          // Handling various states of the orders
          if (state.status == OrdersStatus.failure) {
            return Center(child: Text('${AppConstants.error}: ${state.error}'));
          }
          if (state.orders.isEmpty) {
            return Center(child: Text(AppConstants.noOrdersAvailable));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(_generateChartData(state.orders)),
          );
        },
      ),
    );
  }

  // Helper method to generate the chart data
  LineChartData _generateChartData(List<Order> orders) {
    // Group orders by year and month
    final groupedOrders = _groupOrders(orders);

    // Convert the grouped data into chart spots
    final spots = _generateSpots(groupedOrders);

    return LineChartData(
      gridData: _buildGridData(),
      titlesData: _buildTitlesData(groupedOrders),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue.withOpacity(0.3),
          ),
        ),
      ],
      minY: 0,
    );
  }

  // Group orders by month and year
  Map<DateTime, List<Order>> _groupOrders(List<Order> orders) {
    return Map.fromEntries(
      groupBy(
        orders,
        (order) => DateTime(order.registered.year, order.registered.month),
      ).entries.toList()
        ..sort((a, b) => a.key.month.compareTo(b.key.month)),
    );
  }

  // Generate spots for the chart from the grouped orders
  List<FlSpot> _generateSpots(Map<DateTime, List<Order>> groupedOrders) {
    return groupedOrders.entries
        .mapIndexed((index, entry) =>
            FlSpot(index.toDouble(), entry.value.length.toDouble()))
        .toList();
  }

  // Build grid data for the chart
  FlGridData _buildGridData() {
    return const FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
    );
  }

  // Build titles data for both axes
  FlTitlesData _buildTitlesData(Map<DateTime, List<Order>> groupedOrders) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        axisNameWidget: Text(AppConstants.ordersCountAxisTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value.toInt().toString()),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        axisNameWidget: Text(AppConstants.timeAxisTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1, // Adjust the interval between titles on the bottom axis
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index >= 0 && index < groupedOrders.length) {
              final date = groupedOrders.keys.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${date.month}',
                  style: const TextStyle(fontSize: 10),
                ),
              );
            }
            return const Text('');
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
