import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

Widget buildBannerSection(List<dynamic> banners) {
  return CarouselSlider(
    options: CarouselOptions(height: 200.0, autoPlay: true),
    items: banners.map((bannerUrl) {
      return Builder(
        builder: (BuildContext context) {
          return Image.network(bannerUrl);
        },
      );
    }).toList(),
  );
}