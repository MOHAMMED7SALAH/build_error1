import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/categorisModel.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:saffi/ui/widget/webViewPage.dart';

class CustomSliderImage extends StatefulWidget {
  final double height;

  final List<CategoriesModel> sliderList;
  const CustomSliderImage({Key key, this.height, this.sliderList})
      : super(key: key);
  @override
  CustomSliderImageState createState() => CustomSliderImageState();
}

class CustomSliderImageState extends State<CustomSliderImage> {
  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            height: widget.height,
            initialPage: currentIndexPage,
            enlargeCenterPage: false,
            autoPlay: true,
            reverse: false,
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            pauseAutoPlayOnTouch: Duration(seconds: 3),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                currentIndexPage = index;
              });
            },
            items: List.generate(
              widget.sliderList.length,
              (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (widget.sliderList[index].url != "") {
                              push(
                                  context,
                                  WebViewPage(
                                    url: widget.sliderList[index].url,
                                  ));
                            }
                          },
                          child: networkImage(
                            "${widget.sliderList[index].img}",
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: widget.sliderList.length,
              position: currentIndexPage.toDouble(),
              decorator: DotsDecorator(
                color: Colors.white,
                activeColor: primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
