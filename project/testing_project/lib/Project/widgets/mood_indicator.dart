import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DynamicCircularPercentIndicator extends StatelessWidget {
  final List<Map<String, dynamic>> moods;

  const DynamicCircularPercentIndicator({super.key, required this.moods});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: _buildIndicators(),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    double startAngle = 0.0;

    for (var item in moods) {
      indicators.add(
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 20.0,
          percent: item['percent'],
          progressColor: item['color'],
          backgroundColor: Colors.transparent,
          startAngle: startAngle,
        ),
      );
      startAngle += 360 * item['percent'];
    }
    return indicators;
  }
}
