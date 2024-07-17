import 'package:as_demo1/main.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
class HomeAll extends StatefulWidget {
  const HomeAll({Key? key}) : super(key: key);

  @override
  _HomeAllState createState() => _HomeAllState();
}

class _HomeAllState extends State<HomeAll> {
  Future<Widget> musicInfoWidget(String musicPath, int index) async {
    var metaData = await readMetadata(File(musicPath));
    var title = metaData.title;
    var album = metaData.album;
    var artist = metaData.artist;
    var duration = metaData.duration?.inSeconds.toString();
    return InkWell(
      onTap: () async {
        Provider.of<DataModel>(context, listen: false).changeIndex(index);
        Provider.of<DataModel>(context, listen: false).ready2PlaySong();
        //Provider.of<DataModel>(context, listen: false).play();
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              ClipOval(
                  child: Container(
                color: Colors.green,
                width: 48,
                height: 48,
                child: const Icon(
                  Icons.music_note_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              )),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white.withOpacity(0),
                      child: Text(
                        '$title',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      child: Text(
                        '$artist',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          title: const Text(
            '所有歌曲',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0),
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 20, bottom: 10),
            child: Consumer<DataModel>(
              builder: (context, dataModel, _) {
                return Center(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    var songs = dataModel.songs;
                    return FutureBuilder(
                        future: musicInfoWidget(songs.elementAt(index),index),
                        builder: (context, snapshot) {
                          // 请求已结束
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              // 请求失败，显示错误
                              return Text("Error: ${snapshot.error}");
                            } else {
                              // 请求成功，显示数据
                              return snapshot.data!;
                            }
                          } else {
                            // 请求未结束，显示loading
                            return const CircularProgressIndicator();
                          }
                        });
                  },
                  itemCount: dataModel.songs.length,
                ));
              },
            ),
          ),
        ));
  }
}
