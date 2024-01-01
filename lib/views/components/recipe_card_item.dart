import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/images.dart';
import 'star_widget.dart';

class ReciepeCardItem extends StatelessWidget {
   String ? todayImg;
   String ? recommendedImg;
  final bool isTodayRecipe ;


   ReciepeCardItem({super.key,  this.todayImg, this.recommendedImg,
  required this.isTodayRecipe , });

  @override
  Widget build(BuildContext context) {
    return  Card(
                            elevation: 1,
                            color: llightGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
      
                            // width: MediaQuery.of(context).size.width,
                            // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            // decoration: BoxDecoration(
                            //     color: llightGrey,
                            //     borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: 
                              isTodayRecipe ?

                              Column(children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: ImageIcon(
                                    AssetImage(
                                      ImagePath.likeIcon,
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      todayImg!,
                                      height: 70,
                                      fit: BoxFit.fitHeight,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Breakfast",
                                      style: TextStyle(
                                          fontSize: 12, color: deepGreen),
                                    ),
                                    const Text(
                                      "French Toast with Berries",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                      ],
                                    ),
                                    Text(
                                      "120 Calories",
                                      style: TextStyle(
                                        color: deepOrange,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                            ImagePath.timeIcon,
                                          ),
                                        ),
                                        Text("15 mins",
                                            style: TextStyle(
                                              color: ligthGrey,
                                              fontSize: 12,
                                            )),
                                        ImageIcon(
                                          AssetImage(
                                            ImagePath.servingIcon,
                                          ),
                                        ),
                                        Text("1 Serving",
                                            style: TextStyle(
                                              color: ligthGrey,
                                              fontSize: 12,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ])

                              :

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              
                                Image.asset(
                                  recommendedImg!,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Breakfast",
                                      style: TextStyle(
                                          fontSize: 12, color: deepGreen),
                                    ),
                                    const Text(
                                      "French Toast with Berries",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                        StarWidget(),
                                      ],
                                    ),
                                    Text(
                                      "120 Calories",
                                      style: TextStyle(
                                        color: deepOrange,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                            ImagePath.timeIcon,
                                          ),
                                        ),
                                        Text("15 mins",
                                            style: TextStyle(
                                              color: ligthGrey,
                                              fontSize: 12,
                                            )),
                                        ImageIcon(
                                          AssetImage(
                                            ImagePath.servingIcon,
                                          ),
                                        ),
                                        Text("1 Serving",
                                            style: TextStyle(
                                              color: ligthGrey,
                                              fontSize: 12,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                            ));
  }
}