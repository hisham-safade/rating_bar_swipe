library rating_bar_swipe;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rating_bar;

class Rating extends StatefulWidget {
  const Rating({
    Key? key,
    this.initialRating = 1.0,
    this.itemSize = 30.0,
    this.unSelectedColor,
    this.selectedColor,
    this.selectedIcon,
    this.iterativeValue = 1,
    this.isVertical,
    required this.functionUpdateRating,
  }) : super(key: key);
  final double initialRating;
  final Function functionUpdateRating;
  final double itemSize;
  final double iterativeValue;
  final IconData? selectedIcon;
  final Color? unSelectedColor;
  final Color? selectedColor;
  final Axis? isVertical;

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rate = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              ' ${rate.toStringAsFixed(1)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  rating_bar.RatingBarIndicator(
                    rating: rate,
                    itemBuilder: (context, index) => Icon(
                      widget.selectedIcon ?? Icons.star,
                      color: widget.selectedColor ?? Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: widget.itemSize,
                    unratedColor: widget.unSelectedColor ?? Colors.grey,
                    direction: widget.isVertical ?? Axis.horizontal,
                  ),
                  Positioned(
                    bottom: 0,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        trackShape: const RectangularSliderTrackShape(),
                        trackHeight: 64.0,
                        disabledThumbColor: Colors.transparent,
                        // thumbColor: Colors.white.withOpacity(0.5) ,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0.0),
                        // overlayColor: Colors.transparent.withAlpha(0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: GestureDetector(
                          child: Slider(
                        min: -1,
                        max: 49,
                        divisions:5~/widget.iterativeValue ,
                        value: 0,
                        // widget.initialRating,
                        onChangeEnd: (double value) async {},
                        onChangeStart: (double value) {},
                        onChanged: (double value) {
                          if (value < 50) {
                            value++;
                          }
                          log(value.toString());
                          widget.functionUpdateRating(value);
                          setState(() {
                            rate = (value / 10);
                          });
                        },
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
