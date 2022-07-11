import 'package:amazon_clone_flutter/constants/global_varaibles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((carousal) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              carousal,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ));
  }
}
