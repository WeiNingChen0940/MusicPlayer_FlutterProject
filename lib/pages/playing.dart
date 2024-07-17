import 'package:as_demo1/main.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
class Playing extends StatefulWidget {
  const Playing({Key? key}) : super(key: key);

  @override
  _PlayingState createState() => _PlayingState();
}

class _PlayingState extends State<Playing> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withOpacity(0.5),
                Colors.white,
              ])),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          title: const Text('播放',style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<DataModel>(
          builder: (context, dataModel, _){
            return Center(
                child: Column(

                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        color: Colors.white,
                        child: Container(
                          height: 300,
                          width: 300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(dataModel.songTitle,style: const TextStyle(fontSize: 30,color: Colors.white),),
                    Text(dataModel.songArtist,style: const TextStyle(fontSize: 20,color: Colors.white),),
                    const Text('未检测到歌词文件',style: TextStyle(fontSize: 20,color: Colors.white70),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: () {},
                        ),
                        IconButton(
                          tooltip: '播放/暂停',
                          icon: Icon(
                            dataModel.isPlaying?Icons.pause_outlined:Icons.play_arrow_outlined,
                            size: screenWidth * 0.08,
                          ),
                          onPressed: () {
                            if(dataModel.isPlaying){
                              dataModel.pause();
                            }else{
                              dataModel.play();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                )
            );
          },
        )

      ),
    );

  }
}
