import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class MusicPlayerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 56,
                  width: screenWidth,
                  color: Colors.white10,
                ),
              ),
            )
          ),

        Positioned(
          right: 0,
            child: SizedBox(
              height: 56 ,
              width: 56,
              child: IconButton(icon: Icon(Icons.play_arrow_outlined), color: Colors.black, onPressed: () {  },),
            )
        ),
      ],
    );
  }
}