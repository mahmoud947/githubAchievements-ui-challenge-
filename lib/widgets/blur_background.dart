// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BluerBackground extends StatelessWidget {
  const BluerBackground({
    Key? key,
    this.color,
    required this.child,
    this.width = 30,
    this.height = 30,
  }) : super(key: key);

  final Color? color;
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                color: Colors.transparent,
                child: Container(
                  color: color != null
                      ? color?.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: child,
          )
        ],
      ),
    );
  }
}
