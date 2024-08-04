import 'package:expense_repository/expense_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/screens/add_expense/blocs/get_categories/get_categories_cubit.dart';

import 'indicator.dart';

class PieChartStat extends StatefulWidget {
  const PieChartStat({super.key});

  @override
  State<StatefulWidget> createState() => _PieChartStatState();
}

class _PieChartStatState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (context) =>
              GetCategoriesCubit(FirebaseExpenseRepo())..getCategories(),
          child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              List<Category> categories = [];

              if (state is GetCategoriesSuccess) {
                categories = state.categories;
              }

              return Row(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: _showingSections(categories),
                        ),
                      ),
                    ),
                  ),
                    Wrap(
                        direction: Axis.vertical,
                        spacing: 2,
                        runSpacing: 2,
                        alignment: WrapAlignment.end,
                        children: List.generate(categories.length, (index) {
                          Category category = categories[index];
                          return Indicator(
                              color: Color(category.color),
                              text: category.name,
                              isSquare: true);
                        })
                    ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> _showingSections(List<Category> categories) {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    if (categories.isEmpty) {
      return [
       PieChartSectionData(
        color: Colors.purple,
        value: 0,
        title: '0%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      )
      ];
    }
    int totalExpenses = categories
        .map((category) => category.totalExpenses)
        .reduce((a, b) => a + b);

    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      final category = categories[i];
      final percentage = (category.totalExpenses / totalExpenses) * 100;

      return PieChartSectionData(
        color: Color(category.color),
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
