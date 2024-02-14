import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/views/components/snackbar_widget.dart';
import 'package:daily_recipe/views/filter_screen_view/filter_screen_components/meal_type_widget.dart';
import 'package:daily_recipe/views/filter_screen_view/filter_screen_components/slider_widget.dart';
import 'package:daily_recipe/views/filtered_screen_view/filtered_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../components/text_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var selectedUserValue = {};
  String mealType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      //  AppBar(
      //   // backgroundColor: orange,
      //   automaticallyImplyLeading: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    "Reset",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: orange),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "Meal",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            Wrap(
                // space between chips
                spacing: 25,
                // list of chips
                children: [
                  MealTypeWidget(
                    txt: "Breakfast",
                    selectedUserValue: selectedUserValue,
                    tap: () {
                      selectedUserValue['type'] = "Breakfast";
                      mealType = 'Breakfast';
                      setState(() {});
                    },
                  ),
                  MealTypeWidget(
                    txt: "Launch",
                    selectedUserValue: selectedUserValue,
                    tap: () {
                      selectedUserValue['type'] = "Launch";
                      mealType = 'Launch';
                      setState(() {});
                    },
                  ),
                  MealTypeWidget(
                    txt: "Dinner",
                    selectedUserValue: selectedUserValue,
                    tap: () {
                      selectedUserValue['type'] = "Dinner";
                      mealType = 'Dinner';
                      setState(() {});
                    },
                  ),
                  MealTypeWidget(
                    txt: "Main Dish",
                    selectedUserValue: selectedUserValue,
                    tap: () {
                      selectedUserValue['type'] = "Main Dish";
                      mealType = 'Main Dish';
                      setState(() {});
                    },
                  )
                ]),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "Serving",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SliderWidget(
              isServing: true,
              max: 12,
              min: 1,
              change: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "Preparation Time",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SliderWidget(
              min: 15,
              max: 135,
              change: 30,
              isTime: true,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "Calories",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SliderWidget(
              change: 100,
              min: 82,
              max: 650,
              isCalories: true,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextButtonWidget(
                press: ()
                 {
                  print("mealType");
                  print(mealType);
                  
                  mealType.isNotEmpty
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FilteredScreen(
                                    serv: Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .servingValue
                                        .toInt(),
                                    time: Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .timeValue
                                        .toInt(),
                                    type: mealType!,
                                  )))
                      :  
                       SnackBarWidget(
              context: context, txt: "Please determine Meal Type",color: Colors.red).makeSnackBar();
                },
                txt: "Apply",
                color: orange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
