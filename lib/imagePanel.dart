import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Image $i',
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
