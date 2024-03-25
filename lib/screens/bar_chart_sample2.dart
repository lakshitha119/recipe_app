import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/circle_loader.dart';
import '../services/api.dart';

import '../utils/app_colors.dart';
import '../utils/constant.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({
    super.key,
  });

  final Color leftBarColor = AppColors.contentColorYellow;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor = AppColors.contentColorOrange;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  // late List<BarChartGroupData> rawBarGroups;
  var showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    // _startDateController.text = DateTime.now().toString().split(" ")[0];
    // DateTime sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
    // fetchDataAndBuildChart(sixDaysAgo.toString().split(" ")[0],DateTime.now().toString().split(" ")[0]);
  }

  generateColor(String NutritionName) {
    switch (NutritionName) {
      case "Total lipid (fat)":
        return Colors.red[400];
      case "Carbohydrate, by difference":
        return Colors.yellow[400];
      case "Cholesterol":
        return Colors.brown[400];
      case "Protein":
        return Colors.green[400];
      default:
        return Colors.grey[300];
    }
  }

  var dateDataList = [];

  var titles = [];

  Future<void> fetchDataAndBuildChart(List data) async {
    titles = [];

    dateDataList = data;

    final List<BarChartGroupData> barGroups =
        List.generate(dateDataList.length, (index) {
      titles.add(dateDataList[index]["date"]
          .toString()
          .split("T")[0]
          .replaceAll("2024-", ""));
      List<BarChartRodData> barList = [];
      if (dateDataList[index]["nutrients"].length != 0) {
        barList = [];
        for (var nItem in dateDataList[index]["nutrients"]) {
          var amo = double.parse(nItem["amount"].toString()) / 5;
          print(amo);
          barList.add(BarChartRodData(
            toY: double.parse(nItem["amount"].toString()) / 5,
            color: generateColor(nItem["name"].toString()),
            width: width,
          ));
        }
        return BarChartGroupData(
          barsSpace: 4,
          x: index,
          barRods: barList,
        );
      } else {
        return makeGroupData(index, 0, 0);
      }
    });

    setState(() {
      // rawBarGroups = barGroups;
      showingBarGroups = List.of(barGroups);
    });

    CircleLoader.hideLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     makeTransactionsIcon(),
            //     const SizedBox(
            //       width: 38,
            //     ),
            //     const Text(
            //       'Date Wise Chart',
            //       style: TextStyle(color: Colors.black, fontSize: 14),
            //     ),
            //   ],
            // ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.pink,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        // String tooltipText = 'Y:${rodIndex} ${groupIndex}';
                        var data =
                            dateDataList[groupIndex]["nutrients"][rodIndex];
                        String tooltipText = data["name"] +
                            " - " +
                            data["amount"].toStringAsFixed(2).toString();

                        return BarTooltipItem(
                          tooltipText,
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = 'L';
    } else if (value == 25) {
      text = 'M';
    } else if (value == 50) {
      text = 'H';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
      ],
    );
  }
}
