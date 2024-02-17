import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWidget extends StatelessWidget {
  bool? isTime;
  bool? isCalories;
  bool? isServing;
  num? min;
  num? max;
  double? change;
  SliderWidget(
      {super.key,
      this.isCalories,
      this.isServing,
      this.isTime,
      required this.max,
      required this.min,
      required this.change});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (BuildContext context, value, Widget? child) => SfSlider(
        min: min,
        max: max,
        value: (isCalories == true)
            ? value.caloriesValue.toInt()
            : (isServing == true)
                ? value.servingValue.toInt()
                : (isTime == true)
                    ? value.timeValue.toInt()
                    : 4,
        interval: change!,
        //showTicks: true,
        showLabels: true,
        enableTooltip: true,
        inactiveColor: simiGrey,
        activeColor: orange,
        //minorTicksPerInterval: 1,
        onChanged: (dynamic value2) {
          if (isCalories == true) {
            value.rebuildCalories(value2);
          } else if (isServing == true) {
            value.rebuildServing(value2);
          } else if (isTime == true) {
            value.rebuildTime(value2);
          }
        },
      ),
    );
  }
}
