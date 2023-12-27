import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController crslController = CarouselController();
  int imgPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ImageIcon(
              AssetImage(
                ImagePath.menuIcon,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ImageIcon(
                AssetImage(
                  ImagePath.notificationIcon,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              CarouselSlider(
                carouselController: crslController,
                options: CarouselOptions(
                  height: 370.0,
                  viewportFraction: 0.65,
                  enlargeCenterPage: true,

                  onPageChanged: (index, reason) {
                    imgPosition = index;
                    setState(() {});
                  },
                ),
                items: ImagePath.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                                color: llightGrey,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Column(children: [
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
                                    i,
                                  )),
                               Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Breakfast" , style: TextStyle(
                                      fontSize: 12,
                                      color: deepGreen),),
                                    Text("French Toast with Berries"  , style: TextStyle(fontSize: 18),),
                                    IconButton(onPressed: (){},
                                     icon: Icon(Icons.star_rounded ,
                                    //  fill: ,
                                      color: ligthGrey,
                                      size: 32,
                                      )),
                                    Text("120 Calories" , style: TextStyle(color: deepOrange , fontSize: 12,),
          
                                    ),
                                     Row(children: [
                                       ImageIcon(
                                  AssetImage(
                                    ImagePath.timeIcon,
                                  ),),
                                      Text("15 mins" , style: TextStyle(color: ligthGrey , fontSize: 12,)),
                                       ImageIcon(
                                  AssetImage(
                                    ImagePath.servingIcon,
                                  ),),
                                      Text("1 Serving", style: TextStyle(color: ligthGrey , fontSize: 12,))
                                    ],)
                                  ],
                                ),
                              ),
                            ]),
                          ));
                    },
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                heightFactor: 2.5,
                child: IconButton(
                  onPressed: () {
                    crslController.previousPage();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 30,
                    color: orange,
                    weight: 20,
                    fill: 1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                heightFactor: 2.5,
                child: IconButton(
                  onPressed: () {
                    crslController.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined,
                      fill: 1, size: 30, color: orange, weight: 20),
                ),
              )
            ]),
            DotsIndicator(
              dotsCount: ImagePath.images.length,
              position: imgPosition,
              onTap: (position) async {
                await crslController.animateToPage(position);
                imgPosition = position;
                setState(() {});
              },
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ));
  }
}
