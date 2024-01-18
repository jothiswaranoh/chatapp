import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBody extends StatelessWidget {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ];

  final List<String> captions = [
    'Caption 1',
    'Caption 2',
    'Caption 3',
    'Caption 4',
    'Caption 5',
    'Caption 6',
    'Caption 7',
    'Caption 8',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          enlargeCenterPage: false,
          viewportFraction: 0.3,
        ),
        itemCount: imgList.length,
        itemBuilder: (context, index, realIdx) {
          double imageWidth = MediaQuery.of(context).size.width * 0.8 / 3;
          double imageHeight = MediaQuery.of(context).size.height * 0.8 / 2;

          return Container(
            width: imageWidth,
            height: imageHeight,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imgList[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    captions[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
