import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartGraph extends StatefulWidget {
  const ChartGraph({super.key});

  @override
  State<ChartGraph> createState() => _ChartGraphState();
}

class _ChartGraphState extends State<ChartGraph> {
  @override
  Widget build(BuildContext context) {
    return BarChart(barChartData());
  }

  BarChartData barChartData() {
    return BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: getLeftTitles)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: getTiles)),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: showingBarGroups());
  }

  Widget getTiles(double value, TitleMeta meta) {
    String text = '';

    switch (value.toInt()) {
      case 0:
        text = '01';
        break;
      case 1:
        text = '02';
        break;
      case 2:
        text = '03';
        break;
      case 3:
        text = '04';
        break;
      case 4:
        text = '05';
        break;
      case 5:
        text = '06';
        break;
      case 6:
        text = '07';
        break;
      case 7:
        text = '08';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
        ));
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    String text = '';

    switch (value) {
      case 0:
        text = '\$ 1k';
        break;
      case 2:
        text = '\$ 2k';
        break;
      case 3:
        text = '\$ 3k';
        break;
      case 4:
        text = '\$ 4k';
        break;
      case 5:
        text = '\$ 5k';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
        ));
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y,
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.tertiary,
          ], transform: const GradientRotation(pi / 50)),
          width: 12,
          backDrawRodData: BackgroundBarChartRodData(
              show: true, toY: 5, color: Colors.grey[300]))
    ]);
  }

  List<BarChartGroupData> showingBarGroups() => List.generate(8, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 3.8);
          case 5:
            return makeGroupData(5, 1.5);
          case 6:
            return makeGroupData(6, 4);
          case 7:
            return makeGroupData(7, 3.8);
          default:
            throw Error();
        }
      });
}
