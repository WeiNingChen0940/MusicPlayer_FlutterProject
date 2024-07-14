import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPlayerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BottomAppBar(
      color: Colors.blueGrey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {},
          ),
          CircleAvatar(
            radius: screenWidth * 0.08,
            backgroundImage: NetworkImage('https://example.com/album-cover.jpg'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {},
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}