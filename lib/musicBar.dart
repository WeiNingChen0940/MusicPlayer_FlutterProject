import 'package:as_demo1/main.dart';
import 'package:as_demo1/pages/playing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class MusicBar extends StatefulWidget {
  const MusicBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MusicBarState();
  }
}

class _MusicBarState extends State<MusicBar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<DataModel>(builder: (context, dataModel, _) {
      return ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05),
            //height: 56,
            width: screenWidth,
            color: Colors.white.withOpacity(0),
            child: Row(
              children: [
                ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      color: Colors.white,
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: Icon(
                        Icons.music_note_outlined,
                        color: Colors.black,
                        size: screenWidth * 0.08,
                      ),
                    )),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Playing()),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white.withOpacity(0),
                            width: screenWidth * 0.45,
                            child: Text(
                              dataModel.songTitle,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.45,
                            child: Text(
                              dataModel.songArtist,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child:
                  IconButton(
                    tooltip: '播放/暂停',
                    icon: Icon(
                      dataModel.isPlaying?Icons.pause_outlined:Icons.play_arrow_outlined,
                      size: screenWidth * 0.08,
                    ),
                    onPressed: () {
                      if(!dataModel.isPlaying){
                        dataModel.play();
                      }else{
                        dataModel.pause();
                      }
                    },
                  ),

                ),
                Positioned(
                  width: screenWidth * 0.2,
                  right: 0,
                  child: IconButton(
                    tooltip: '下一曲',
                    icon: Icon(Icons.skip_next_outlined,
                        size: screenWidth * 0.08),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}